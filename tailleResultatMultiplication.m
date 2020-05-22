% Fonction 8
% 
% Retourne les dimensions de la matrice résultante du produit matriciel * 
% des matrices A et B. Si les matrices ne sont pas compatibles, la fonction 
% retourne 0. Par exemple, pour une matrice 10x4, la fonction retourne la 
% matrice [10, 4].
% Indice : il existe une fonction MATLAB qui retourne la taille 
% d’une matrice.

function [outputResult] = tailleResultatMultiplication(A,B)
    sizeA = size(A);
    sizeB = size(B);
    doesInnerMatrixMatch = (sizeA(1,2) == sizeB(1,1));
    if (doesInnerMatrixMatch == 1)
        outputResult = size(A*B);
    else
        outputResult = 0;
    end
end