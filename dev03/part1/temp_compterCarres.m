% function decompte = compterCarres(image)
% end

% input : image
% M x N sized logical where M: height, N: width
% output : decompte
% Matrix of 1x20 of double/uint32 where n element = # of size squares
image = imread('carres.png');

%       INFORMATION
% recommended : hit or miss approach with erosion/dilations
%       FUNCTIONS
% 1) Hit or Miss :    C = bwhitmiss(A, B1, B2)
% 2) Erosion :        C = imopen(A, B)
% 3) Dilation :       C = imclose(A, B)
%       RESOURCES
% https://www.mathworks.com/help/images/ref/bwhitmiss.html


% ============== start ======================

% store received image
recImage = image;
% generate a 1x20 table to store final results
tableResults = zeros(1,20, 'uint32');

% converts image to a matrix w/ labelled connected components
% and the number of total shapes
[imageMat, numberFormesA] = bwlabel(recImage);

erode1_ES = strel('square', 15);
erode1 = imerode(recImage, erode1_ES);
dilate1_ES = strel('square', 15);
dilate1 = imdilate(erode1, dilate1_ES);

% D = imerode(C, b1);

% -- class notes HIT OR MISS implementation
% erosion1 =  A - b1
% erosion2 = !A - b2
% hitmissResult = ero1 AND ero2


% result = bwhitmiss(imageMat,b1, b2);

% saves results for output of function
decompte = tableResults;

% ----------------------------- DEBUG
% because the background is black, invert it when imshow
% figure(1), imshow(~recImage);
[imageMat2, numberFormesA2] = bwlabel(erode1);
% [imageMat3, numberFormesA3] = bwlabel(D);

% subplots/display
subplot(1,3,1)
imshow(~recImage)
title('Original');

subplot(1,3,2)
imshow(~erode1)
title('Erode1');

subplot(1,3,3)
imshow(~dilate1)
title('Dilate1');
