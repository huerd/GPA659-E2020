function [fraises, vert] = trouverFraises(imageFraises)
imageFraises =imread('Fraises.jpg');
lab = rgb2lab(imageFraises);
l = lab(:,:,1);
a = lab(:,:,2);
b = lab(:,:,3);

figure(2)
subplot(2,2,1), imshow(l,[]), title('L')
subplot(2,2,2), imshow(a,[]), title('a')
subplot(2,2,3), imshow(b,[]), title('b')
subplot(2,2,4), imshow(imageFraises,[]), title('rgb');

red_a = 62;
red_b = 25;

masque_fraise = vecnorm(cat(3,a,b) -cat(3,red_a,red_b),2,3) < 20;
fraises = imageFraises .* uint8(masque_fraise);

green_a = -12;
green_b = 39;

masque_vert = vecnorm(cat(3,a,b) -cat(3,green_a,green_b),2,3) < 13;
vert = imageFraises .* uint8(masque_vert);

figure(3), imshow(fraises,[]), title('fraises');
figure(4), imshow(vert,[]), title('vert');

figure(8)
subplot(1,2,1), imshow(fraises,[]), title('fraises')
subplot(1,2,2), imshow(vert,[]), title('vert')

end
