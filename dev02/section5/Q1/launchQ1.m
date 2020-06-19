f = imread('navette.jpg');
% TEST = imshow(log(abs(fftshift(fft2(f)))),[]);
spectrumLogMagnitude = afficherMagnitudeFourier(f);


figure(1), imshowpair(f,spectrumLogMagnitude,'montage');
title('Original Image vs spectrumLogMagnitude', 'FontSize', 20)

% %%----------------------------%%area of the histogram
% widthBin = 1600;
% resultHistogram = histogram(spectrumLogMagnitude,widthBin)
% title('Histogram Distribution', 'FontSize', 20)
% counts = resultHistogram.Values;
% sum_counts = sum(counts);
% width = resultHistogram.BinWidth;
% area = sum_counts*width;
%----------------------------%area of the histogram
% equalHist = histcounts(f,0:256);



%%----------------------------%%filder
% [Du, Dv] = size(f); % taille du masque identique à celle de f
% D = @(u,v) ((u-Du/2).^2 + (v-Dv/2).^2).^0.5; % distance euclidienne au centre
% D0 = 0.02; % le petit rayon
% W = 0.006; % la largeur de l'anneau
% [v,u] = meshgrid(1:Dv,1:Du);
% filterImpl = double((D(u,v) < D0) | (D(u,v) > (D0+W)));
% View filter
% figure(4), imshow(filterImpl);
% title('Frequency Mask', 'FontSize', 20)
%%----------------------------%%filder
% filterImpl = fspecial('gaussian',size(f));
%%----------------------------%%filder
% gmean = @(A) uint8(prod(double(A)) .^ (1 / size(A,1)));
% fp = padarray(f, [3 3], 'replicate', 'both')
% filterImpl = colfilt(fp, [3 3], 'sliding', gmean)
% tt = afficherMagnitudeFourier(filterImpl)
%%----------------------------%% FILTER MIN 
% minFilter = ordfilt2(f, 1, [0 1 0 ; 1 1 1; 0 1 0], 'symmetric')
% figure(2), imshowpair(f,minFilter,'montage');
% title('Original Image vs minFilter', 'FontSize', 20)
%%----------------------------%% FILTER MEDIAN 
[m,n] = size(f);
medFilter = ordfilt2(f, ceil(m*n),ones(m,n), 'symmetric')
figure(2), imshowpair(f,medFilter,'montage');
title('Original Image vs medFilter', 'FontSize', 20)


% -----------------TEST FILTERS
% h = ones(3) ./ 9;
% g = imfilter(f,h,'symmetric');
% -----------------TEST FILTERS

% g = appliquerFiltreFrequentiel(fp,tt);
g = filtrerImageQ1(f);
% Display Comparison Results
figure(3), imshowpair(f,g,'montage');
title('Original Image vs Applied Filters', 'FontSize', 20)
% erreur = evaluerSolutionQ1(g);
