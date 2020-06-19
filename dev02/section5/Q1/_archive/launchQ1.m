f = imread('navette.jpg');
processed = filtrerImageQ1(f);
figure(3), imshowpair(f,processed,'montage');
title('Original Image vs Final Image', 'FontSize', 20)
erreur = evaluerSolutionQ1(processed);
