clear all
close all
clc

A=imread('squares.tif');
subplot(1,2,1)
imshow(A)

hit=[0 0 0; 
    0 1 1; 
    0 1 1] % the pattern you want

miss=~hit

Ares=bwhitmiss(A,hit,miss);

subplot(1,2,2)
imshow(Ares)