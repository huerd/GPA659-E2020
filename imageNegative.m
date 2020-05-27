function [g] = imageNegative(f)
%IMAGENEGATIVE Summary of this function goes here
%   Detailed explanation goes here
    g=255-rgb2gray(f);
end

