% Fonction 2
% La fonction prend un vecteur V en paramètre, et change la valeur du 16e élément de la
% matrice pour 4. Le nouveau vecteur B est retourné.
function [output] = modifierElement4(input)
    elementToTarget = 16;
    valueToInsert = 4;
    input(elementToTarget) = valueToInsert;
    output = input;
end