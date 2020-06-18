function v = gmean(A)
mn = size(A, 1); % La longueur des colonnes de A est toujours mn.
v = uint8(prod(double(A)) .^ (1 / mn));