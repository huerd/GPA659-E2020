function [colorName] = getNameFromRGB(r,g,b)
%GETNAMEFROMRGB Summary of this function goes here
%   Detailed explanation goes here
    
    %r = color(:,1);
    %g = color(:,1);
    %b = color(:,1);
    colorName = 'blanc';
    fprintf('%i |', r);
    fprintf('%i |', b);
    fprintf('%i | ', g)
    if( r >= 110 && r<=130 && g >= 45 && g<=255 && b >=45 && b <=255 )
        colorName = 'bleu';
    else
        colorName = 'blanc';
    end
    %colorName = 'rouge';
    %colorName = 'vert';
    %colorName = 'jaune';
    %colorName = 'mauve';
    %colorName = 'rose';
    disp(colorName);
end

