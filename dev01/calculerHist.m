function H = calculerHist(A)
    % [EVAL] : while Matlab tends to count arrays starting from 1, in the
%     context of functions, 1:256 are inclusive, so you should state 0:256
%     instead and get a 1x256 double returned as a result.
    matrixVal = histcounts(A,1:256);
    H = matrixVal;
end