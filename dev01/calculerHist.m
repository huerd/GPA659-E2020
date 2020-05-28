function H = calculerHist(A)
    matrixVal = histcounts(A,1:256);
    H = matrixVal;
end