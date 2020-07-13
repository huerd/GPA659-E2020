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
[imageMat, numberFormes] = bwlabel(recImage);

b1 = strel('square', 4);
C = imopen(recImage, b1);

% result = bwhitmiss(imageMat,b1, b2);
imshowpair(~recImage,C,'montage');

% saves results for output of function
decompte = tableResults;

% ----------------------------- DEBUG
% because the background is black, invert it when imshow
% figure(1), imshow(~recImage);