% Fonction 4
% Soit la matrice A et la matrice i. La fonction initialise à 34 les valeurs dans A dont la position
% est contenue dans la matrice i. Par exemple, si 𝐴 = [1 2 3 4 ] et 𝑖 = [2 4] , alors
% 𝐵 = [1 34 3 34] . Par plus de deux lignes de code. Référez-vous à l’exercice 1.
function B = initialiser34(A,i)
    valueToInsert = 34;
    A(i) = valueToInsert;
    B = A;
end