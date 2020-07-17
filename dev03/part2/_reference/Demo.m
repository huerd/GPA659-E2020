% Demo to mask square tiles and measure their mean RGB from an RGB image.  By Image Analyst, April 16, 2020.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clearvars;
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 16;
% Read in image.
folder = pwd;
baseFileName = 'org_1.png';
fullFileName = fullfile(folder, baseFileName);
rgbImage = imread(fullFileName);
[rows, columns, numberOfColorChannels] = size(rgbImage);
% Display the original image.
h1 = subplot(1, 2, 1);
imshow(rgbImage, []);
axis('on', 'image');
caption = sprintf('Original Color Image\n"%s"', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.
% Set up figure properties:
% Enlarge figure to full screen.
hFig = gcf;
hFig.Units = 'Normalized';
hFig.WindowState = 'maximized';
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
hFig.Name = 'Demo by Image Analyst';
hFig.NumberTitle = 'Off'
hsvImage = rgb2hsv(rgbImage);
mask = hsvImage(:, :, 2) > 0.25; % Only consider really vivid pixels, not gray ones.
% Fill noise holes
mask = imfill(mask, 'holes');
% Get the areas
% props = regionprops(mask, 'Area');
% areas = sort([props.Area], 'Descend')
% Take the 16 biggest blobs:
mask = bwareafilt(mask, 16);
mask = bwareaopen(mask, 1000); % Remove noise.
% Display the image.
h2 = subplot(1, 2, 2);
imshow(mask);
axis('on', 'image');
title('Mask Image of Square Tiles', 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.
% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
% Get red means
propsR = regionprops(mask, redChannel, 'MeanIntensity', 'Centroid');
allMeansR = [propsR.MeanIntensity];
% Get green means
propsG = regionprops(mask, greenChannel, 'MeanIntensity', 'Centroid');
allMeansG = [propsG.MeanIntensity];
% Get red means
propsB = regionprops(mask, blueChannel, 'MeanIntensity', 'Centroid');
allMeansB = [propsB.MeanIntensity];
% Print the values
for k = 1 : length(propsR)
	caption = sprintf('Tile %d', k);
	% First on the color image.
	text(h1, propsR(k).Centroid(1), propsR(k).Centroid(2), caption, ...
		'Color', 'k', 'FontSize', 20, 'HorizontalAlignment', 'center');
	% Then on the mask
	text(h2, propsR(k).Centroid(1), propsR(k).Centroid(2), caption, ...
		'Color', 'b', 'FontSize', 20, 'HorizontalAlignment', 'center');
	
	fprintf('For Tile #%2.2d, Mean RGB = (%.3f, %.3f, %.3f).\n', ...
		k, allMeansR(k), allMeansG(k), allMeansB(k));
end
msgbox('Done!');