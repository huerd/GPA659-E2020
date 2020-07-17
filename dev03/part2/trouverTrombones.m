function [x,y,c] = trouverTrombones(image)
%TROUVERTROMBONES Summary of this function goes here
%   Detailed explanation goes here

f=im2double(imread('trbn1.jpg'));
hsv=rgb2hsv(f);
t = hsv-f;
c=t(:,:,3);
m3=medfilt2(c);
gf3=m3>graythresh(m3);
bloss= gf3+t-f;

%methode recommander ****
f=im2double(imread('trbn1.jpg'));
hsv=rgb2hsv(f);

b= hsv(:,:,2) > (graythresh(hsv(:,:,2))+0.08);
c= hsv(:,:,3) > (graythresh(hsv(:,:,3))-0.08);
dc= b+c-f;

CC=bwconncomp(dc);
S = regionprops(CC, 'Centroid');
x=[];
y=[];
c=[];
%'rouge', 'vert', 'bleu', 'mauve', 'rose','jaune', 'blanc'.

end

