% function [bulle, groupes] = compteBulles(image)
% end

%  -------------------------------------------- Prep Stage
% clean environment
clc;
close all; 
clear;
workspace; 

image = imread('bulles.bmp');

% convert to logical if it isn't
if (~islogical(image))
    % ensure to conver to grayscale if not
    if (size(image,3) == 3)
        image = rgb2gray(image);
    end
    image = logical(image);
end

% store received image
recImage = image;

% --------------------------------------------------- first method
% directly counting through table filtering of regionprops - not sure if we
% should use this, but keeping it as reference/comparison
imgStats = regionprops('table', bwlabel(recImage), 'Area', 'Centroid','MajorAxisLength','MinorAxisLength');
centerpointAll = imgStats.Centroid;
diametersAll = mean([imgStats.MajorAxisLength imgStats.MinorAxisLength],2);
radiusAll = diametersAll/2;

imgStatsSolo = imgStats(imgStats.Area <=400,:);
centerpointSolo = imgStatsSolo.Centroid;
diametersSolo = mean([imgStatsSolo.MajorAxisLength imgStatsSolo.MinorAxisLength],2);
radiusSolo = diametersSolo/2;

imgStatsGrouped = imgStats(imgStats.Area >=400,:);
centerpointGrouped = imgStatsGrouped.Centroid;
diametersGrouped = mean([imgStatsGrouped.MajorAxisLength imgStatsGrouped.MinorAxisLength],2);
radiusGrouped = diametersGrouped/2;

% --------------------------------------------------- second method
% find isolated balls, subtract for grouped formes

[imgConverted, numbFormesInitial] = bwlabel(recImage);

imgIsolate = imgConverted;

% extract the number of pixels for each conn.comp
pretreat = bwconncomp(imgIsolate);
numPixels = cellfun(@numel,pretreat.PixelIdxList);

% iterate through every numPixels array
for i = 1 : length(numPixels)
    % if the result is over 400, assume amas and set to zero
    if numPixels(i) >= 400
        imgIsolate(pretreat.PixelIdxList{i}) = 0;
    end
end

% subtract isolated balls from initial image
imgSubtractedMain = and(imgConverted, ~imgIsolate);

% extract the number of pixels for each conn.comp
pretreat = bwconncomp(imgSubtractedMain);
numPixels = cellfun(@numel,pretreat.PixelIdxList);

% iterate through every numPixels array
for i = 1 : length(numPixels)
    % if the result is less than 400 (from imperfect subtraction), set to 0
    if numPixels(i) <= 400
        imgSubtractedMain(pretreat.PixelIdxList{i}) = 0;
    end
end

% get shape count and transfer results
[imgIsolateMat, numImgIsolate] = bwlabel(imgIsolate);
[imgSubtractedMainMat, numSubtractedMain] = bwlabel(imgSubtractedMain);

bulle = numImgIsolate;
groupes = numSubtractedMain;

% ----------------------------- DEBUG subplot display outputs
subplot(1,5,1)
imshow(image)
title(['Original : ' num2str(numbFormesInitial) ' found ']);

subplot(1,5,2)
imshow(image)
hold on
viscircles(centerpointAll,radiusAll,'Color','b');
hold off
title('w/ Circles on all forms');

subplot(1,5,3)
imshow(image)
hold on
viscircles(centerpointSolo,radiusSolo,'Color','b');
hold off
hold on
viscircles(centerpointGrouped,radiusGrouped,'Color','c');
hold off
title('w/ Circles, isolated');

subplot(1,5,4)
imshow(imgIsolate)
title('imgIsolate');
title(['imgIsolate : ' num2str(numImgIsolate) ' found ']);

subplot(1,5,5)
imshow(imgSubtractedMainMat)
title(['subtractedMain : ' num2str(numSubtractedMain) ' found ']);