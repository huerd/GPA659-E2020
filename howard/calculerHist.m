% Fonction 11

% La fonction reçoit une matrice A contenant des 
% nombres entre 0 et 255, puis calcule l’histogramme à 256 classes. 

% L’histogramme est retourné sous la forme d’une matrice H de 256 valeurs.
% Prenez le temps de lire la documentation MATLAB sur les histogrammes 
% et apprenez à afficher votre histogramme sous la forme d’un graphique, 
% ceci vous sera utile pour les prochains laboratoires. 

% Expérimentez aussi
% avec les fonctions suivantes : plot(H), bar(H) et scatter(0:255,H), où H
% est le retour de votre fonction.

% Note : ceci est la question la moins bien réussie, testez 
% attentivement votre fonction! Par exemple, calculerHist(0)
% retourne [1 0 0 0 ...] et calculerHist(255) retourne [0 0 0 ... 1].
function [outputResult] = calculerHist(A)
    h = histogram(A,1:256);
    outputResult = h.Values;
end