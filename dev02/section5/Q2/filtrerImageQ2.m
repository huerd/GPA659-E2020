function [imageFiltree] = filtrerImageQ2(image)
image = imread('lena.jpg');

% spectrumLogMagnitude = afficherMagnitudeFourier(f);
% figure(1), imshowpair(f,spectrumLogMagnitude,'montage');
% title('Original Image vs spectrumLogMagnitude', 'FontSize', 20)

% Cette solution pour lena.jpg a une erreur quadratique moyenne de 45.4072
%%----------------------------%% Butterworth
[M, N] = size(image); % taille du masque identique à celle de f
D = @(u,v) ((u-M/2).^2 + (v-N/2).^2).^0.5; % distance euclidienne au centre
D0 = 48; % inner ring
W = 3; % outer ring
[v,u] = meshgrid(1:N,1:M);
filter = double((D(u,v) < D0) | (D(u,v) > (D0+W)));

filter = medfilt2(filter,[5,5]);

% spectrumLogMagnitude = afficherMagnitudeFourier(filter);
% figure(1), imshowpair(f,spectrumLogMagnitude,'montage');
% title('Original Image vs spectrumLogMagnitude', 'FontSize', 20)

% Display Comparison Results
imageFiltree = appliquerFiltreFrequentiel(image,filter);
% figure(3), imshowpair(image,imageFiltree,'montage');
% title('Original Image vs Final Image', 'FontSize', 20)
% erreur = evaluerSolutionQ2(imageFiltree);
end
