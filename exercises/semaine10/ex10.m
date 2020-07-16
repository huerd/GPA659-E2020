i1 = imread('gauche.png');
i2 = imread('droite.png');

i1gray = rgb2gray(i1);
i2gray = rgb2gray(i2);

% % imshowpair(i1gray,i2gray,'montage');

% detect key points in each image
i1points = detectSURFFeatures(i1gray);
i2points = detectSURFFeatures(i2gray);

% show keypoints found in image 1. used to determine relative position
figure(1)
imshow(i1);
hold on;
plot(selectStrongest(i1points,100));
title('Best 100 found features using SURF');

% to establish between left/right images, associate and filter keypoints

% extract the features of each image from points
[features1, validBlobs1] = extractFeatures(i1gray, i1points);
[features2, validBlobs2] = extractFeatures(i2gray, i2points);

% measure keypoint distances
indexPairs = matchFeatures(features1, features2);
matchedPoints1 = validBlobs1(indexPairs(:,1),:);
matchedPoints2 = validBlobs2(indexPairs(:,2),:);

figure(2)
showMatchedFeatures(i1, i2, matchedPoints1, matchedPoints2);
title('Associated keypoints between two images');

% estimating fundamental matrix
[fMatrix, epipolarInliers] = estimateFundamentalMatrix(matchedPoints1, matchedPoints2);
inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

figure(3)
showMatchedFeatures(i1, i2, inlierPoints1, inlierPoints2);
title('Matched features between two images');

[t1, t2] = estimateUncalibratedRectification(fMatrix, inlierPoints1.Location, inlierPoints2.Location, size(i2));
tform1 = projective2d(t1);
tform2 = projective2d(t2);
[I1Rect, I2Rect] = rectifyStereoImages(i1, i2, tform1, tform2);

figure(4)
imshow(stereoAnaglyph(I1Rect, I2Rect));
title('Stereo Anaglyph');

i1rectgray = rgb2gray(I1Rect);
i2rectgray = rgb2gray(I2Rect);

figure(5)
imshow(disparity(i1rectgray,i2rectgray,'DisparityRange',[0 128]));
% colormap jet
colorbar
