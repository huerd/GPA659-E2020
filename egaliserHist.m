% Fonction 18
% La fonction applique l’égalisation d’histogramme sur l’image f via la fonction MATLAB,
% puis retourne le résultat. Vous devez trouver la fonction dans l’aide de MATLAB, puis
% l’appliquer.

function [outputResult] = egaliserHist(A)
    % converts img to greyscale if needed
    if (size(A,3) == 3)
        A = rgb2gray(A);
    end
    outputResult = histeq(A);
end

