function [imageFiltree] = filtrerImageQ1(image)
% Cette solution pour navette.jpg a une erreur quadratique moyenne de 58.6019
imageFiltree = medfilt2(image,[5,5]);
imageFiltree = medfilt2(imageFiltree,[2,2]);
imageFiltree = medfilt2(imageFiltree,[3,3]);
imageFiltree = medfilt2(imageFiltree,[1,1]);
imageFiltree = medfilt2(imageFiltree,[3,3]);
imageFiltree = medfilt2(imageFiltree,[5,5]);
end