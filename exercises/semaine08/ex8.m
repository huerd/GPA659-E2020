imgBricks = imread("bricks.jpg");
figure(1), imshow(imgBricks);
imgCarpet = imread("carpet.jpg");
figure(2), imshow(imgCarpet);

lbpBricks = extractLBPFeatures(imgBricks, 'Upright', false);
lbpCarpet = extractLBPFeatures(imgCarpet, 'Upright', false);

if randi(2) == 1
M = imread("bricks.jpg");
else
M = imread("carpet.jpg"); 
end

x0 = randi(size(M,1)/2);
x1 = randi(size(M,1)/2) + size(M,1)/2;
y0 = randi(size(M,2)/2);
y1 = randi(size(M,2)/2) + size(M,2)/2;
M = M(x0 :x1, y0 :y1);
M = imrotate(M, randi(5), "crop");

figure(3), imshow(M);