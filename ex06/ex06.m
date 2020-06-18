M = zeros(500, 500);
imshow(M);
set(gcf,'color','black');
line(randi(500,1,2), randi(500,1,2));
M = rgb2gray(imnoise(frame2im(getframe(gcf))));
close all;
imshow(M);
seuillage = M > 50;
% imshowpair(M,seuillage,'montage');
subplot(1,3,1), imshow(M)
subplot(1,3,2), imshow(seuillage)
subplot(1,3,3), imshow(seuillage)