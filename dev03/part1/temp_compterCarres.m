% function decompte = compterCarres(image)
% end

% input : image
% M x N sized logical where M: height, N: width
% output : decompte
% Matrix of 1x20 of double/uint32 where n element = # of size squares
% image = imread('carres.png');

%       INFORMATION
% recommended : hit or miss approach with erosion/dilations
%       FUNCTIONS
% 1) Hit or Miss :    C = bwhitmiss(A, B1, B2)
% 2) Erosion :        C = imopen(A, B)
% 3) Dilation :       C = imclose(A, B)
%       RESOURCES
% https://www.mathworks.com/help/images/ref/bwhitmiss.html

% ============== start ======================

clc;
close all; 
clear;
workspace; 

image = imread('carres.png');

% store received image
recImage = image;
originalImg = recImage;
% generate a 1x20 table to store final results
tableResults = zeros(1,20, 'uint32');

% ------------------------Pre-treat by removing all non-squares
pretreat = bwconncomp(recImage)
numPixels = cellfun(@numel,pretreat.PixelIdxList);

% iterate through every numPixels array
for i = 1 : length(numPixels)
    % if the result isn't whole, set that connected label to zero
    if ceil(sqrt(numPixels(i))) ~= sqrt(numPixels(i))
        recImage(pretreat.PixelIdxList{i}) = 0;
    end
end

% converts image to a matrix w/ labelled connected components
[imageMat, numbFormesInitial] = bwlabel(recImage);

shapeSize = 5;
erode1_ES = strel('square', shapeSize);

erode1 = imerode(imageMat, erode1_ES);

% we want to detect single pixels
hit = [0 0 0; 
       0 1 0; 
       0 0 0]

% % use hitmiss to count single pixel hits
% hitmissResult = bwhitmiss(erode1, hit, ~hit);

% dilate single pixels to shape, subtract from original
dilate1_ES = strel('square', shapeSize);
dilate1 = imdilate(erode1, dilate1_ES);

stateToRemove = dilate1;
subtractedState = and(imageMat, ~stateToRemove);


% saves results for output of function
decompte = tableResults;

% ----------------------------- DEBUG
% because the background is black, invert it when imshow

% count w/ hitmiss of single pix
[originalMat, numOriginal] = bwlabel(originalImg);

% count the squares after erode/dilate
[imageMat2, numberFormesA2] = bwlabel(stateToRemove);
% count w/ hitmiss of single pix
[imageMat4, numberFormesA4] = bwlabel(recImage);
% count after subtraction
[imageMat3, numberFormesA3] = bwlabel(subtractedState);

% subplots/display
subplot(2,3,1)
imshow(originalMat)
title('Original');

subplot(2,3,2)
imshow(imageMat4)
title('Original (Squares only)');

subplot(2,3,3)
imshow(~erode1)
title('Erode');

subplot(2,3,4)
imshow(~dilate1)
title('Dilate');

subplot(2,3,5)
imshow(~subtractedState)
title('subtractedState');

subplot(2,3,6)
imshow('Fraises.jpg')
title('Placeholder');


