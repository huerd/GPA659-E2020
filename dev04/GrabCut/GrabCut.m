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
im_number = 30; 
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

%% Calcul des histogrammes permetttant d'estimer la probabilite qu'un pixel appartienne e l'avant-plan et l'arriere-plan
[objProbabilitees, bkgProbabilitees] = calculerProbabilitesParPixel(image, masque);
% le format suivant est necessaire pour la fonction de coupe de graphe:
% elle ne sait sait pas qu'il s'agit d'une image, elle opere sur des noeuds
% de graphe. La connectivite de ces noeuds est definie e l'etape suivante.
probabilitesParPixel = [objProbabilitees(:), bkgProbabilitees(:)]';

% figure(1)
% imshow(objProbabilitees,[]), colormap('jet'), colorbar, title('-log(probabilite) que le pixel apartienne e l''avant-plan')
% figure(2)
% imshow(bkgProbabilitees,[]), colormap('jet'), colorbar, title('-log(probabilite) que le pixel apartienne e l''arriere-plan')

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
E = computeEnergy(neighborhoodWeights, double(L==1), objProbabilitees, bkgProbabilitees);
% 5) supression de l'objet de coupe de graphe
BK_Delete(BKhandle); % toujours appeler ceci e chaque fois qu'on utilise le grabcut.
clear BKhandle;

%% Affichage de la solution
% figure; imagesc(image); axis image; axis off; hold on;
% [c,h] = contour(L, 'LineWidth',3,'Color', 'r');
% title(sprintf('Solution du GrabCut - energie = %.2f',E)) % note: on cherche e minimiser l'energie

% ==============================================
subplot(2,2,1)
imshow(objProbabilitees,[]), colormap('jet'), colorbar
title('-log(prob) que le pixel apartienne avant-plan')
%
subplot(2,2,2)
imshow(bkgProbabilitees,[]), colormap('jet'), colorbar
title('-log(prob) que le pixel apartienne arriere-plan')
% 
subplot(2,2,3)
imshow(originalImage)
title('Original Image')
% 
subplot(2,2,4)
imagesc(image); axis image; axis off; hold on;
[c,h] = contour(L, 'LineWidth',3,'Color', 'r');
title(sprintf('SolutionGrabCub E = %.2f',E)) % note: on cherche e minimiser l'energie


