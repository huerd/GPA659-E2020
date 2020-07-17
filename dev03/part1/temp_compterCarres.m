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

%  -------------------------------------------- Prep Stage
% clean environment
clc;
close all; 
clear;
workspace; 

image = imread('carres.png');

% convert to logical if it isn't
if (~islogical(image))
    % ensure to conver to grayscale if not
    if (size(image,3) == 3)
        image = rgb2gray(image);
    end
    image = logical(image);
end

% size of table (also max possible sizes of square)
tableSize = 20
% store received image
recImage = image;
% save original image (debug purpose)
originalImg = image;
% generate a 1x20 table to store final results
tableResults = zeros(1, tableSize, 'uint32');

% -------------------------------------------- Pre-treatment Stage
% in this stage, we will remove all formes that are not perfect squares

% get all connected components of image
pretreat = bwconncomp(recImage)
% extract the number of pixels for each conn.comp
numPixels = cellfun(@numel,pretreat.PixelIdxList);

% iterate through every numPixels array
for i = 1 : length(numPixels)
    % if the result isn't whole, set that connected label to zero
    if ceil(sqrt(numPixels(i))) ~= sqrt(numPixels(i))
        recImage(pretreat.PixelIdxList{i}) = 0;
    end
end

% converts pre-treated image to a matrix w/ labelled connected components
[recImageMat, numbFormesInitial] = bwlabel(recImage);

% -------------------------------------------- Main Processing Stage
% Strategy : 
% 1 - from tableSize:1, where currentTableSize = n, descending
% 2 - eliminate all squares not of nxn dimension through erosion
% 3 - dilate and save to results table
% 4 - using dilated results, subtract from original


for currentTableSize = length(tableResults):-1:1
    % generale the appropriate square to hit
    shapeSize = currentTableSize;
    squareToHit = strel('square', shapeSize);

    % erode to single pixel
    erode1 = imerode(recImageMat, squareToHit);

    % dilate single pixels to its original shape
    stateToRemove = imdilate(erode1, squareToHit);

    % register count to our tableResults
    [imageMat2, numCountDilated] = bwlabel(stateToRemove);
    tableResults(shapeSize) = numCountDilated;

    % subtract the dilated squares from the initial state
    recImageMat = and(recImageMat, ~stateToRemove);
end

% -------------------------------------------- transfer results
decompte = tableResults;

% ----------------------------- DEBUG subplot displays

% bwlabel of original image
[originalMat, numOriginal] = bwlabel(originalImg);
% count w/ hitmiss of single pix
[recMat, numRec] = bwlabel(recImage);

% subplots/display
subplot(2,2,1)
imshow(originalMat)
title('Original');

subplot(2,2,2)
imshow(recImageMat)
title('recMat');

subplot(2,2,3)
imshow(~erode1)
title('Erode');

subplot(2,2,4)
imshow(~stateToRemove)
title('stateToRemove');

