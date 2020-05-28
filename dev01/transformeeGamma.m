function g = transformeeGamma(f)
    if (size(f,3) == 3)
        f = rgb2gray(f);
    end
    gammaVal = 2;
    
    doublef = double(f);
    gammaCorrected = ((doublef./255).^gammaVal).*255;
    g = uint8(gammaCorrected);
end