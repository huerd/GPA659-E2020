% Fonction 9
% Soit la matrice A de taille 3x3. La fonction modifie la matrice A 
% pour que tous les éléments de la 3e colonne soient 0, puis retourne 
% le résultat. Vous ne pouvez pas utiliser de boucle for ou while.
function [outputResult] = changerColonne3x3(A)
    sizeOfA = size(A);
    A(:,sizeOfA(1,2)) = zeros(1,sizeOfA(1,1));
    outputResult = A;
end