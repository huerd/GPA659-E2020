% clean environment
clc;
close all; 
clear;
workspace; 

image = im2double(imread('trbn1.jpg'));

% store received image
recImage = image;

imgHSV = rgb2hsv(recImage);

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
hold(imgca,'on')
plot(imgca,centroids(:,1), centroids(:,2), 'r*')
hold(imgca,'off')
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
title('PLACEHOLDER');

subplot(3,3,6)
imshow(imgHSVTreshed)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('PLACEHOLDER');

subplot(3,3,7)
imshow(imgHSVTreshed)
% hold on
% viscircles(centerpointAll,radiusAll,'Color','b');
% hold off
title('PLACEHOLDER');

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

figure(2)
imshow(image)
hold(imgca,'on')
plot(imgca,centroids(:,1), centroids(:,2), 'r*')
hold(imgca,'off')
title(['Original + Centroids']);