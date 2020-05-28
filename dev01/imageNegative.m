function [g] = imageNegative(f)
    % converts to greyscale if RGB
    if (size(f,3) == 3)
        f = rgb2gray(f);
    end
    g=255 - f;
end

