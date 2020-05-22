% Fonction 15
% Reçoit une image f (type uint8) en paramètre, la convertit en 
% niveau de gris si elle comporte de la couleur (size(f,3) == 3),
% applique une compression d’histogramme de facteur 2 (divise toutes 
% les valeurs par deux), puis une translation d’histogramme de 64 vers
% la droite (additionne 64 à chaque valeur). La nouvelle 
% image est retournée.

function [outputResult] = translationCompressionHist(A)
    % converts img to greyscale if needed
    if (size(A,3) == 3)
        A = rgb2gray(A);
    end
    % divide by 2. lowers contrast
    % shift right by 64. increases brightness
    outputResult = A/2 + 64;
end