function [imageFiltree] = filtrerImageQ1(image)
% For debugging
% image = imread('navette.jpg');
% histogram(image);
% magFour = afficherMagnitudeFourier(image);
% figure(1), imshowpair(image,magFour,'montage');

% Cette solution pour navette.jpg a une erreur quadratique moyenne de 58.6019
imageFiltree = medfilt2(image,[5,5]);
imageFiltree = medfilt2(imageFiltree,[2,2]);
imageFiltree = medfilt2(imageFiltree,[3,3]);
imageFiltree = medfilt2(imageFiltree,[1,1]);
imageFiltree = medfilt2(imageFiltree,[3,3]);
imageFiltree = medfilt2(imageFiltree,[5,5]);

% For debugging
% figure(3), imshowpair(image,imageFiltree,'montage');
% title('Original Image vs Applied Filters', 'FontSize', 20)
% erreur = evaluerSolutionQ1(imageFiltree);
end