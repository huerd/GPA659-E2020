% function [bulle, groupes] = compteBulles(image)
% end

%  -------------------------------------------- Prep Stage
% clean environment
clc;
close all; 
clear;
workspace; 

image = imread('bulles.bmp');
image = rgb2gray(image); 

% store received image
recImage = image;
% store results
resultsBulles = 0;
resultsGroupes = 0;

imgStats = regionprops('table', bwlabel(recImage), 'Area', 'Centroid','MajorAxisLength','MinorAxisLength')
centers = imgStats.Centroid;
diameters = mean([imgStats.MajorAxisLength imgStats.MinorAxisLength],2);
radii = diameters/2;

imgConverted = bwconncomp(recImage);
numPixels = cellfun(@numel,imgConverted.PixelIdxList);
smallestComp = min(numPixels);
% hist = histogram(numPixels);
% bins = hist.NumBins

% transfer results
bulle = resultsBulles
groupes = resultsGroupes

% ----------------------------- DEBUG
% subplots/display
subplot(1,4,1)
imshow(image)
title('Original');

subplot(1,4,2)
imshow(image)
hold on
viscircles(centers,radii,'Color','b');
hold off
title('w/ Circles on all forms');
subplot(1,4,3)
imshow(image)
hold on
viscircles(centers,radii,'Color','b');
hold off
title('w/ Circles, isolated vs grouped');
subplot(1,4,4)
imshow(image)
hold on
viscircles(centers,radii,'Color','b');
hold off
title('placeholder');