function g = egaliserHist(f)
    % converts img to greyscale if needed
    if (size(f,3) == 3)
        f = rgb2gray(f);
    end
    g = histeq(f);
end

