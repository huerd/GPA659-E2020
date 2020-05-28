function S = tailleResultatMultiplication(A,B)
    sizeA = size(A);
    sizeB = size(B);
    doesInnerMatrixMatch = (sizeA(1,2) == sizeB(1,1));
    if (doesInnerMatrixMatch == 1)
        S = size(A*B);
    else
        S = 0;
    end
end