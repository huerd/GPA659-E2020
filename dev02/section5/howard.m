f = imread('navette.jpg');
h = ones(3) ./ 9;
g = imfilter(f,h,'symmetric');
erreur = evaluerSolutionQ1(g);