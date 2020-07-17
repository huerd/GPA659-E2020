function [x,y,c] = trouverTrombones(image)
%TROUVERTROMBONES Summary of this function goes here
%   Detailed explanation goes here

f=im2double(imread('trbn1.jpg'));
hsv=rgb2hsv(f);
b= hsv(:,:,2) > (graythresh(hsv(:,:,2))-0.08);
bw = imfill(b,'holes');
L = bwlabel(bw);
s = regionprops(L, 'centroid');
centroids = cat(1, s.Centroid);
imshow(f)
hold(imgca,'on')
plot(imgca,centroids(:,1), centroids(:,2), 'r*')
hold(imgca,'off')

CC=bwconncomp(dc);
S = regionprops(CC, 'Centroid');
x=[];
y=[];
c=[];
%'rouge', 'vert', 'bleu', 'mauve', 'rose','jaune', 'blanc'.

end

