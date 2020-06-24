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

imshow(M);