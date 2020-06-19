f = imread('navette.jpg');
% TEST = imshow(log(abs(fftshift(fft2(f)))),[]);
spectrumLogMagnitude = afficherMagnitudeFourier(f);
figure(1), imshowpair(f,spectrumLogMagnitude,'montage');
title('Original Image vs spectrumLogMagnitude', 'FontSize', 20)

% %%----------------------------%%area of the histogram
resultHistogram = histogram(f)
title('Histogram Distribution', 'FontSize', 20)
counts = resultHistogram.Values;
sum_counts = sum(counts);
width = resultHistogram.BinWidth;
area = sum_counts*width;
%----------------------------%area of the histogram
% equalHist = histcounts(f,0:256);

%%----------------------------%% Butterworth
[Du, Dv] = size(f); % taille du masque identique à celle de f
D = @(u,v) ((u-Du/2).^2 + (v-Dv/2).^2).^0.5; % distance euclidienne au centre
D0 = 1500; % inner ring
W = 3000; % outer ring
[v,u] = meshgrid(1:Dv,1:Du);
filter = double((D(u,v) < D0) | (D(u,v) > (D0+W)));
figure(2), imshowpair(f,filter,'montage');
title('Original Image vs Freq Mask', 'FontSize', 20)
%%----------------------------%%filder
% filterImpl = fspecial('gaussian',size(f));
%%----------------------------%% colFit
% gmean = @(A) uint8(prod(double(A)) .^ (1 / size(A,1)));
% fp = padarray(f, [3 3], 'replicate', 'both')
% colFilter = colfilt(fp, [3 3], 'sliding', gmean)
% filter = afficherMagnitudeFourier(colFilter)
% figure(2), imshowpair(f,filter,'montage');
% title('Original Image vs colFit', 'FontSize', 20)
% %%----------------------------%% FILTER MIN 
% filter = ordfilt2(f, 1, [0 1 0 ; 1 1 1; 0 1 0], 'symmetric')
% figure(2), imshowpair(f,filter,'montage');
% title('Original Image vs minFilter', 'FontSize', 20)
%%----------------------------%% FILTER MAX 
% filter = ordfilt2(f, 3*3, ones(3,3), 'symmetric')
% figure(2), imshowpair(f,filter,'montage');
% title('Original Image vs maxFilter', 'FontSize', 20)
%%----------------------------%% FILTER MEDIAN 
% filter = ordfilt2(f, ceil(3*3/2),[0 1 0 ; 1 1 1; 0 1 0], 'symmetric')
% figure(2), imshowpair(f,filter,'montage');
% title('Original Image vs medFilter', 'FontSize', 20)

% -----------------TEST FILTERS
% h = ones(3) ./ 9;
% g = imfilter(f,h,'symmetric');
% -----------------TEST FILTERS

% 
% g = appliquerFiltreFrequentiel(spectrumLogMagnitude,spectrumFilter);
% figure(3), imshowpair(spectrumLogMagnitude,g,'montage');
% title('spectrumLogMagnitude vs g', 'FontSize', 20)
% erreur = evaluerSolutionQ1(g);


% g = appliquerFiltreFrequentiel(f,medFilter);
% g = filtrerImageQ1(f);
% Display Comparison Results
g = appliquerFiltreFrequentiel(f,filter);
figure(3), imshowpair(f,g,'montage');
title('Original Image vs Final Image', 'FontSize', 20)
erreur = evaluerSolutionQ1(g);
