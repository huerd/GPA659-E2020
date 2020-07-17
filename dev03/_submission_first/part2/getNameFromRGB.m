function [colorName] = getNameFromRGB(r,g,b)
%GETNAMEFROMRGB Summary of this function goes here
%   Detailed explanation goes here
    
    %r = color(:,1);
    %g = color(:,1);
    %b = color(:,1);
    colorName = 'blanc';
    fprintf('%i |', r);
    fprintf('%i | ', g)
    fprintf('%i |', b);
    %colorName = 'bleu';
    %colorName = 'blanc';
    %colorName = 'rouge';
    %colorName = 'vert';
    %colorName = 'jaune';
    %colorName = 'mauve';
    %colorName = 'rose';
    disp(colorName);
end

