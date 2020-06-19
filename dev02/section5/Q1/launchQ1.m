f = imread('navette.jpg');
% TEST = imshow(log(abs(fftshift(fft2(f)))),[]);
spectrumLogMagnitude = afficherMagnitudeFourier(f);
% figure(1), imshowpair(f,spectrumLogMagnitude,'montage');
% title('Original Image vs spectrumLogMagnitude', 'FontSize', 20)

% %%----------------------------%%area of the histogram
% resultHistogram = histogram(f)
% title('Histogram Distribution', 'FontSize', 20)
% counts = resultHistogram.Values;
% sum_counts = sum(counts);
% width = resultHistogram.BinWidth;
% area = sum_counts*width;
%----------------------------%area of the histogram
% equalHist = histcounts(f,0:256);

processed = medfilt2(f,[5,5]);
currentMSE = loopSolution(processed);
processed = medfilt2(processed,[2,2]);
currentMSE = loopSolution(processed);
processed = medfilt2(processed,[3,3]);
currentMSE = loopSolution(processed);
processed = medfilt2(processed,[1,1]);
currentMSE = loopSolution(processed);
processed = medfilt2(processed,[3,3]);
currentMSE = loopSolution(processed);
processed = medfilt2(processed,[5,5]);
currentMSE = loopSolution(processed);






%----------------------------% LOW PASS
% a=histogram(f);
% passe1 = medfilt2(f,[3,5]);
% a1=histogram(passe1);
% passe2 = medfilt2(passe1,[9,1]);
% passe3 = medfilt2(passe2,[3,5]);
% passe4 = medfilt2(passe3,[1,1]);
% passe5 = medfilt2(passe4,[1,1]);
% g = medfilt2(passe5,[3,1]);
%%----------------------------%% Butterworth
% [M, N] = size(f); % taille du masque identique à celle de f
% D = @(u,v) ((u-M/2).^2 + (v-N/2).^2).^0.5; % distance euclidienne au centre
% D0 = 15; % inner ring
% W = 3000; % outer ring
% [v,u] = meshgrid(1:N,1:M);
% filter = double((D(u,v) < D0) | (D(u,v) > (D0+W)));
% figure(2), imshowpair(f,filter,'montage');
% title('Original Image vs Freq Mask', 'FontSize', 20)
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
% g = appliquerFiltreFrequentiel(f,filter);
figure(3), imshowpair(f,processed,'montage');
title('Original Image vs Final Image', 'FontSize', 20)
erreur = evaluerSolutionQ1(g);
