% Fonction 17
% Reçoit une image (type uint8) en paramètre, la convertit en niveau de gris si nécessaire, la
% convertit en type double, applique une correction gamma de puissance 2 
function [output] = transformeeGamma(f)
    if (size(f,3) == 3)
        f = rgb2gray(f);
    end
    gammaVal = 2;
    
    doublef = double(f);
    gammaCorrected = ((doublef./255).^gammaVal).*255;
    output = uint8(gammaCorrected);
end