function g = translationCompressionHist(f)
    % converts img to greyscale if needed
    if (size(f,3) == 3)
        f = rgb2gray(f);
    end
    % divide by 2. lowers contrast
    % shift right by 64. increases brightness
    g = f/2 + 64;
end