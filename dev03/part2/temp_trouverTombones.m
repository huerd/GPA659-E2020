% function [x,y,c] = trouverTrombones(image)
% end

% clean environment
clc;
close all; 
clear;
workspace; 
fontSize = 16;

image = im2double(imread('trbn1.jpg'));

% store received image
recImage = image;

imgHSV = rgb2hsv(recImage);
mask = imgHSV(:, :, 2) > 0.25;
maskFilled = imfill(mask, 'holes');

imgHue = imgHSV(:,:,1);
imgSat = imgHSV(:,:,2);
imgInt = imgHSV(:,:,3);

redChannel = image(:, :, 1);
greenChannel = image(:, :, 2);
blueChannel = image(:, :, 3);
% Get red means
propsR = regionprops(maskFilled, redChannel, 'MeanIntensity', 'Centroid');
allMeansR = [propsR.MeanIntensity];
% Get green means
propsG = regionprops(maskFilled, greenChannel, 'MeanIntensity', 'Centroid');
allMeansG = [propsG.MeanIntensity];
% Get red means
propsB = regionprops(maskFilled, blueChannel, 'MeanIntensity', 'Centroid');
allMeansB = [propsB.MeanIntensity];

imgHSVTreshed = imgHSV(:,:,2) > (graythresh(imgHSV(:,:,2))-0.08);

imgFilled = imfill(imgHSVTreshed,'holes');

L = bwlabel(imgFilled);
s = regionprops(L, 'centroid');
centroids = cat(1, s.Centroid);

x=[];
y=[];
c=[];
%'rouge', 'vert', 'bleu', 'mauve', 'rose','jaune', 'blanc'.


% % % ----------------------------- DEBUG subplot display outputs
% used for debugging
% make sure to uncomment the first method code to use this
subplot(3,3,1)
imshow(image)
title(['Original']);

subplot(3,3,2)
imshow(imgHSV)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('imgHSV');

subplot(3,3,3)
imshow(imgHSVTreshed)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('imgHSVTreshed');

subplot(3,3,4)
imshow(imgFilled)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('imgFilled');

subplot(3,3,5)
imshow(image)
hold(imgca,'on')
plot(imgca,centroids(:,1), centroids(:,2), 'r*')
hold(imgca,'off')
title(['Original + Centroids']);

subplot(3,3,6)
imshow(mask)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('mask');

subplot(3,3,7)
imshow(maskFilled)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('maskFilled');

subplot(3,3,8)
imshow(imgHSVTreshed)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('PLACEHOLDER');

subplot(3,3,9)
imshow(imgHSVTreshed)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('PLACEHOLDER');

% figure(2)
% imshow(image)
% hold(imgca,'on')
% plot(imgca,centroids(:,1), centroids(:,2), 'r*')
% hold(imgca,'off')
% title(['Original + Centroids']);

% % Check to see if it's an 8-bit image needed later for scaling).
% if strcmpi(class(image), 'uint8')
%     % Flag for 256 gray levels.
%     eightBit = true;
% else
%     eightBit = false;
% end
% 
% figure(2)
% % Extract out the color bands from the original image
% % into 3 separate 2D arrays, one for each color component.
% redBand = image(:, :, 1);
% greenBand = image(:, :, 2);
% blueBand = image(:, :, 3);
% % Display them.
% subplot(2, 3, 1);
% imshow(redBand);
% title('Red Band', 'FontSize', fontSize);
% subplot(2, 3, 2);
% imshow(greenBand);
% title('Green Band', 'FontSize', fontSize);
% subplot(2, 3, 3);
% imshow(blueBand);
% title('Blue Band', 'FontSize', fontSize);
% 
% % Compute and plot the red histogram.
% hR = subplot(2, 3, 4);
% [countsR, grayLevelsR] = imhist(redBand);
% maxGLValueR = find(countsR > 0, 1, 'last');
% maxCountR = max(countsR);
% bar(countsR, 'r');
% grid on;
% xlabel('Gray Levels');
% ylabel('Pixel Count');
% title('Histogram of Red Band', 'FontSize', fontSize);
% 
% % Compute and plot the green histogram.
% hG = subplot(2, 3, 5);
% [countsG, grayLevelsG] = imhist(greenBand);
% maxGLValueG = find(countsG > 0, 1, 'last');
% maxCountG = max(countsG);
% bar(countsG, 'g', 'BarWidth', 0.95);
% grid on;
% xlabel('Gray Levels');
% ylabel('Pixel Count');
% title('Histogram of Green Band', 'FontSize', fontSize);
% 
% % Compute and plot the blue histogram.
% hB = subplot(2, 3, 6);
% [countsB, grayLevelsB] = imhist(blueBand);
% maxGLValueB = find(countsB > 0, 1, 'last');
% maxCountB = max(countsB);
% bar(countsB, 'b');
% grid on;
% xlabel('Gray Levels');
% ylabel('Pixel Count');
% title('Histogram of Blue Band', 'FontSize', fontSize);
% 
% % Set all axes to be the same width and height.
% % This makes it easier to compare them.
% maxGL = max([maxGLValueR,  maxGLValueG, maxGLValueB]);
% if eightBit
%     maxGL = 255;
% end
% maxCount = max([maxCountR,  maxCountG, maxCountB]);
% axis([hR hG hB], [0 maxGL 0 maxCount]);