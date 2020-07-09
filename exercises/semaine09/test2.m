f = imread('cameraman.tif');
[~,orientation] = imgradient(f);
imshow(orientation,[]);
colormap('jet');
colorbar();