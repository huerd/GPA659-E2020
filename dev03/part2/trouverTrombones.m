%function [x,y,c] = trouverTrombones(image)
%TROUVERTROMBONES Summary of this function goes here
%   Detailed explanation goes here

f=imread('trbn1.jpg');
hsv=rgb2hsv(f);
mr=hsv(:,:,1);
mg=hsv(:,:,2);
mb=hsv(:,:,3);
%masque_red = ?;
%masque_blue = ?;
%masque_green = ?;
%masque_yellow = ?;
%masque_purple = ?;
%masque_pink = ?;
%masque_white = ?;
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
    %envoyer vers la fonction ou appliquer les filtres
    c=[c;getNameFromRGB(k(i,1),k(i,2),k(i,3))];
end
%'rouge', 'vert', 'bleu', 'mauve', 'rose','jaune', 'blanc'.
%end


