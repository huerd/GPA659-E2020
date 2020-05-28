% Fontion 10
% Soit la matrice A de taille 3x3. La fonction modifie la 
% matrice A pour que tous les éléments de la 2e ligne valent 
% le double de leur valeur initiale, puis retourne le résultat. 
% Vous ne pouvez pas utiliser de boucle for ou while.
function [outputResult] = doublerLigne3x3(A)
    A(2,:) = A(2,:)*2;
    outputResult = A;
end