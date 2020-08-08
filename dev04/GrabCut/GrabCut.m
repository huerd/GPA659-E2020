clear;
close('all');
clc;
Addpath_items;

%% Voici la liste des images sur laquelle nous pouvons tester le grabcut
image_set = {'38801G','banana1','banana2','banana3','book','bool','bush','ceramic','cross','doll',...
    'elefant','flower','fullmoon','grave','llama','memorial','music','person1','person2', 'person3',...
    'person4', 'person5', 'person6', 'person7','person8','scissors','sheep','stone1','stone2','teddy',...
    'tennis','21077','24077','37073','65019','69020','86016','106024','124080','153077',...
    '153093','181079','189080','208001','209070','227092','271008','304074','326038','376043'};

%% Quelques parametres...
file_image='Images'; % dossier contenant les images
file_rectangle='Rectangle'; % dossier contenant les rectangles (segmentation initiale approximative)
file_GT='GT'; % dossier contenant le ground truth.

%% Variables qu'on peut modifier
% Il y a 50 images dans le fichier, vous pouvez choisir un nombre entre 1 et 50
% im_number = 13; %moon
% im_number = 15; %llama
im_number = randi([1 50]); %fish
% le lamda pour le criete de regularisation, essayez lambda = 0, 5, 25, 50, 100, ...
lambda = 50; 

%% Chargement de l'image, initialisation et affichage
image_name = image_set{im_number};
img_file = dir(fullfile(file_image, [image_name '.*']));
groundTruth = imread(fullfile(file_GT, [image_name '.bmp']));
image = imread(fullfile(file_image, img_file.name));
originalImage = image;
Rectangle = imread(fullfile(file_rectangle, [image_name '.bmp']));
masque = (Rectangle==128);
[M,N,~] = size(masque);

iterations = 10;

% we'll only store 10 masks
n = 10 ;
storedMask = cell(n, 1) ;
% store our first mask (should be a rect)
storedMask{1} = masque;
timesDrawn = 0;
bestEnergy = 0;
prompted = false;
avantPlan = zeros(M,N);
arrierePlan = zeros(M,N);
running = true;

while running
    for currentIteration=1:iterations
        [objProbabilitees, bkgProbabilitees] = calculerProbabilitesParPixel(image, masque);

        % apply drawn masks to probabilities
        if prompted == true
            % make it the last series iteration
            running = false;
            % save the previous mask
            previousMask = masque;
            
            avantPlan = avantPlan .*99999;
            bkgProbabilitees = bkgProbabilitees + avantPlan;
            
            arrierePlan = arrierePlan .*99999;
            objProbabilitees = objProbabilitees + arrierePlan;
        end
    
        probabilitesParPixel = [objProbabilitees(:), bkgProbabilitees(:)]';
    
        optimizationOptions.NEIGHBORHOOD_TYPE = 8;
        optimizationOptions.LAMBDA_POTTS = lambda;
        optimizationOptions.neighborhoodBeta = computeNeighborhoodBeta(image, optimizationOptions);
        [neighborhoodWeights,~,~] = getNeighborhoodWeights_radius(image, optimizationOptions);
        BKhandle = BK_Create(numel(masque)); % important: creer un nouvel objet grabcut avant chaque utilisation.
        BK_SetNeighbors(BKhandle, neighborhoodWeights);
        [L, ~] = optimizeWithBK(BKhandle, M, N, probabilitesParPixel);
        E = computeEnergy(neighborhoodWeights, double(L==1), objProbabilitees, bkgProbabilitees);
        
        % update our mask with current cut
        masque = ~(L > ones(M,N));

        % store masks after 1 iteration
        if currentIteration > 1
            storedMask{currentIteration} = masque;
        end

        BK_Delete(BKhandle); % toujours appeler ceci e chaque fois qu'on utilise le grabcut.
        clear BKhandle;
    end %% ----------------------- COMPLETE ITERATIONS
    
    if prompted == false
        for prompt = 1:2
            % user prompt 
            figureRect = figure('Position', [350, 350, 900, 900], 'Name', 'CurrentResult');
            imagesc(image); axis image; axis off; hold on;
            [c,h] = contour(L, 'LineWidth',3,'Color', 'y');
            title('Resultat Courant');

            if prompt == 1
                % str = input('Dessigne Constraintes avant-plan? ( [oui] seulement, autres entrees pour finaliser ) : ','s');
                str = questdlg('Ajouter Rect Contrainte avant-plan?','Resultats','oui','non', 'oui');
            else
                % str = input('Dessigne Constraintes arriere-plan? ( [oui] seulement, autres entrees pour finaliser ) : ','s');
                str = questdlg('Ajouter Rect Contrainte arriere-plan?','Resultats','oui','non', 'oui');
            end

            close(findobj('type','figure','name','Filters'))
            close(findobj('type','figure','name','CurrentResult'))

            if strcmp(str, 'oui')
                figureRect = figure('Position', [850, 450, 900, 900]);
                imagesc(image); axis image; axis off; hold on;
                [c,h] = contour(L, 'LineWidth',3,'Color', 'g');
                title('Dessigne Contrainte');
                rect = getrect(figureRect)
                timesDrawn = timesDrawn + 1;
                close(figureRect)

                % round the values
                x1 = floor(rect(1));
                y1 = floor(rect(2));
                x2 = x1 + floor(rect(3));
                y2 = y1 + floor(rect(4));

                % create additive mask
                additiveMask = ones(y2 - y1,x2 - x1);
                drawnMask = zeros(M,N);
                drawnMask(y1 : y2 -1, x1 : x2-1) = additiveMask;

                % register masks depending on the prompt
                if prompt == 1
                    avantPlan = drawnMask;
                else
                    arrierePlan = drawnMask;
                end

            else
                close(findobj('type','figure','name','Filters'))
            end
        end
    end
    prompted = true;
end

%% TODO avec notre masque finale, comparer le avec le masque de GT et
% output Dice index : https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient

diceValue = dice(logical(masque), logical(groundTruth))


%% Affichage de la solution
% ==============================================
% plot positioning
figure1 = figure('Position', [1500, 100, 1024, 1200]);

subplot(3,2,1)
imshow(objProbabilitees,[]), colormap('jet'), colorbar
title('-log(prob) que le pixel apartienne avant-plan ()')
%
subplot(3,2,2)
imshow(bkgProbabilitees,[]), colormap('jet'), colorbar
title('-log(prob) que le pixel apartienne arriere-plan ()')
% 
subplot(3,2,3)
imshow(originalImage)
title('Original Image')
% 
subplot(3,2,4)
imagesc(image); axis image; axis off; hold on;
[c,h] = contour(L, 'LineWidth',3,'Color', 'r');
title(sprintf('SolutionGrabCut E = %.2f',E)) % note: on cherche e minimiser l'energie
% 
subplot(3,2,5)
imshow(storedMask{1})
title('Initial Mask')
title(sprintf('Initial Mask on 1st iteration'))
% 
subplot(3,2,6)
imshow(masque)
title(sprintf('Final Mask after [%d] iterations. Dice Value = [%f]', iterations, diceValue))

% plots only the first 10 masks
figure2 = figure('Position', [50, 1200, 1900, 250],'Name', 'Iteration Masks');
%
for plotter = 1:n
    subplot(1,n,plotter)
    imshow(storedMask{plotter})
    title(sprintf('[%d] iter', plotter))
end

figureDrawnFilters = figure('Position', [1000, 650, 1024, 350], 'Name', 'DrawnFilters');
subplot(1,2,1)
imshow(avantPlan);
title('avantPlan');
%
subplot(1,2,2)
imshow(arrierePlan);
title('arrierePlan');