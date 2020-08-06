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
im_number = 15; %llama
% le lamda pour le criete de regularisation, essayez lambda = 0, 5, 25, 50, 100, ...
lambda = 5; 

%% Chargement de l'image, initialisation et affichage
image_name = image_set{im_number};
img_file = dir(fullfile(file_image, [image_name '.*']));
groundTruth = imread(fullfile(file_GT, [image_name '.bmp']));
image = imread(fullfile(file_image, img_file.name));
originalImage = image;
Rectangle = imread(fullfile(file_rectangle, [image_name '.bmp']));
masque = (Rectangle==128);
[M,N,~] = size(masque);
iterations = 2;

% we'll only store 10 masks
n = 10 ;
storedMask = cell(n, 1) ;
% store our first mask (should be a rect)
storedMask{1} = masque;
bestEnergy = 0;
running = true

while running
    for currentIteration=1:iterations
        %% Calcul des histogrammes permetttant d'estimer la probabilite qu'un pixel appartienne e l'avant-plan et l'arriere-plan
        % i guess masque = the S in the equation, omega is image
        [objProbabilitees, bkgProbabilitees] = calculerProbabilitesParPixel(image, masque);
    
        % le format suivant est necessaire pour la fonction de coupe de graphe:
        % elle ne sait sait pas qu'il s'agit d'une image, elle opere sur des noeuds
        % de graphe. La connectivite de ces noeuds est definie e l'etape suivante.
        
        probabilitesParPixel = [objProbabilitees(:), bkgProbabilitees(:)]';
    
        %% Initialisation de la librarie de coupe de graph
        % 1) on definit les parmetres de regularisation
        optimizationOptions.NEIGHBORHOOD_TYPE = 8;
        optimizationOptions.LAMBDA_POTTS = lambda;
        % la fonction computeNeighborhoodBeta permet de generer une structure qui represente la
        % connectivite de noeuds dans notre graphe en selon la logique de voisinage dans le contexte d'une image.
        optimizationOptions.neighborhoodBeta = computeNeighborhoodBeta(image, optimizationOptions);
        [neighborhoodWeights,~,~] = getNeighborhoodWeights_radius(image, optimizationOptions);
        % 2) on cree un objet grabcut (objet C++)
        BKhandle = BK_Create(numel(masque)); % important: creer un nouvel objet grabcut avant chaque utilisation.
        BK_SetNeighbors(BKhandle, neighborhoodWeights);
    
        % 3) on applique la coupure de graph
        [L, ~] = optimizeWithBK(BKhandle, M, N, probabilitesParPixel);
    
        % 4) (optionel) evaluer la fonction de coet de la solution retenue: l'energie
        % higher E is better segmentation
        E = computeEnergy(neighborhoodWeights, double(L==1), objProbabilitees, bkgProbabilitees);
        
        % store the first segmentation Energy on first iteration, otherwise we
        % compare
        if currentIteration == 1
            sprintf('1st Iteration E is [%d] ', E)
            cropSize = sum(masque(:))
            previousEnergy = E;
        else
            if E > previousEnergy
                % store the as masque? 
    %             masque = ~(L > ones(M,N));
                sprintf('New best E is [%d] at %d iteration', E, currentIteration)
                previousEnergy = E
            end
        end
 
        % save current E for next loop
        previousEnergy = E;
        
        % update our mask with current cut
        masque = and(masque,~(L > ones(M,N)));

        % store masks after 1 iteration
        if currentIteration > 1
            storedMask{currentIteration} = masque;
        end
        % sum of all white space. less is better
        cropSize = sum(masque(:));
        % 5) supression de l'objet de coupe de graphe
        BK_Delete(BKhandle); % toujours appeler ceci e chaque fois qu'on utilise le grabcut.
        clear BKhandle;
    end %% ----------------------- COMPLETE ITERATIONS
    
    % user prompt 
    figureRect = figure('Position', [350, 350, 900, 900]);
    imagesc(image); axis image; axis off; hold on;
    [c,h] = contour(L, 'LineWidth',3,'Color', 'y');
    title('Resultat Courant');
    
    % str = input('Dessigne Constraintes avant-plan? ( [oui] seulement, autres entrees pour finaliser ) : ','s');
    % just for us to avoid debugging
    str = questdlg('Ajouter Rect Contrainte?','Resultats','oui','non', 'oui');
    close(figureRect)
    close(findobj('type','figure','name','Filters'))

    if strcmp(str, 'oui')
        %% TODO draw rect process
        figureRect = figure('Position', [850, 450, 900, 900]);
        imagesc(image); axis image; axis off; hold on;
        [c,h] = contour(L, 'LineWidth',3,'Color', 'g');
        title('Dessigne Contrainte');
        % rect =  [xmin ymin width height]. 
        rect = getrect(figureRect)
        close(figureRect)

        % round the values
        x1 = floor(rect(1));
        y1 = floor(rect(2));
        x2 = x1 + floor(rect(3));
        y2 = y1 + floor(rect(4));
        
        % create additive mask
        additiveMask = ones(y2 - y1,x2 - x1);

        % x2 = x + size(additiveMask,1) - 1;
        % y2 = y + size(additiveMask,2) - 1;
        loadingMask = zeros(M,N);
        loadingMask(y1 : y2 -1, x1 : x2-1) = additiveMask;
        
        combinedMask = xor(loadingMask, masque);

        figureMask = figure('Position', [1500, 100, 1024, 600], 'Name', 'Filters');
        subplot(1,2,1)
        imshow(loadingMask);
        title('loadingMask');
        %
        subplot(1,2,2)
        imshow(combinedMask);
        title('combinedMask');
        
        % 
%         masque = or(masque, combinedMask);
%         masque(x : x2, y : y2) = additiveMask;
        % OR additive mask to current mask

    else
        running = false
        close(findobj('type','figure','name','Filters'))
    end
    
end

cropSize = sum(masque(:))

%% TODO avec notre masque finale, comparer le avec le masque de GT et
% output Dice index : https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient




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
title(sprintf('Final Mask after [%d] iterations', iterations))

% plots only the first 10 masks
figure2 = figure('Position', [50, 1200, 1900, 250]);
%
for plotter = 1:n
    subplot(1,n,plotter)
    imshow(storedMask{plotter})
    title(sprintf('[%d] iter', plotter))
end
