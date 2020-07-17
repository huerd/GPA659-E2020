%function [x,y,c] = trouverTrombones(image)
%TROUVERTROMBONES Summary of this function goes here
%   Detailed explanation goes here

f=imread('trbn1.jpg');
hsv=rgb2hsv(f);
b= hsv(:,:,2) > (graythresh(hsv(:,:,2))-0.08);
bw = imfill(b,'holes');
L = bwconncomp(bw);
s = regionprops(L, 'centroid');
centroids = cat(1, s.Centroid);
[n,d] = size(centroids);
if((n/2)> 0)
   n = round(n/2);
end
[idx,CC] = kmeans(centroids,n, 'distance','sqeuclidean');
CC = round(CC);
imshow(f),hold(imgca,'on')
plot(imgca,CC(:,1), CC(:,2), 'r*')
hold(imgca,'off');
x=CC(:,1);
y=CC(:,2);
c=[];
k=impixel(f,x,y);
for i = 1:n
    c=[c;getNameFromRGB(k(i))];
end
%'rouge', 'vert', 'bleu', 'mauve', 'rose','jaune', 'blanc'.
%end


