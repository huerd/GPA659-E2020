function B = changerColonne3x3(A)
    sizeOfA = size(A);
    A(:,sizeOfA(1,2)) = zeros(1,sizeOfA(1,1));
    B = A;
end