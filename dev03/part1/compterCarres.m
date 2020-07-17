function decompte = compterCarres(image)
%  -------------------------------------------- Prep Stage

% size of table (also equiv to square dimen)
tableSize = 20;
% store received image
recImage = image;
% generate a 1x20 table to store final results
tableResults = zeros(1, tableSize, 'uint32');

% -------------------------------------------- Pre-treatment Stage
% in this stage, we will remove all formes that are not perfect squares

% get all connected components of image
pretreat = bwconncomp(recImage);
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
[recImageMat, ~] = bwlabel(recImage);

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
    [~, numCountDilated] = bwlabel(stateToRemove);
    tableResults(shapeSize) = numCountDilated;

    % subtract the dilated squares from the initial state for next loop
    recImageMat = and(recImageMat, ~stateToRemove);
end

% transfer results
decompte = tableResults;
end