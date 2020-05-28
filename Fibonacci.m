% Fonction 13
% La fonction retourne les 20 premiers termes de la séquence de Fibonacci dans une matrice.
% La séquence peut être calculée de la manière suivante :
function [output] = Fibonacci()
    arrayFibo = zeros(1,20);
    arrayFibo(1) = 1;
    arrayFibo(2) = 1;
    for i = 1:length(arrayFibo)
        if i > 2
            arrayFibo(i) = arrayFibo(i-1) + arrayFibo(i-2);
        end
    end
    output = arrayFibo;
end