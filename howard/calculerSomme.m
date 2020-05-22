% Fonction 14
% La fonction reçoit un scalaire entier n, puis calcule et retourne la 
% somme des nombres entiers
% 6 entre 1 et n. Votre fonction doit s’exécuter en un temps inférieure 
% à 5ms pour n=10 .
function [outputResult] = calculerSomme(A)
%   startingValue = 1;
%   outputResult = sum(startingValue + (0:A - 1));
%     fastest result, since we're not generating arrays
    outputResult = (A*(A+1))/2;
end