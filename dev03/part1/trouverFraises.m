function [fraises, vert] = trouverFraises(imageFraises)

lab = rgb2lab(imageFraises);

l = lab(:,:,1);
a = lab(:,:,2);
b = lab(:,:,3);

red_a = 62;
red_b = 25;

masque_fraise = vecnorm(cat(3,a,b) -cat(3,red_a,red_b),2,3) < 20;
fraisesR = imageFraises .* uint8(masque_fraise);

green_a = -12;
green_b = 39;

masque_vert = vecnorm(cat(3,a,b) -cat(3,green_a,green_b),2,3) < 13;
vertG = imageFraises .* uint8(masque_vert);

% convert to logical
fraises = logical(rgb2gray(fraisesR));
vert = logical(rgb2gray(vertG));

% % verify if logical
% disp(['isLogical : ' num2str(islogical(fraises))])

% % ----------------------------- DEBUG subplot display outputs
% figure(2)
% subplot(4,2,1), imshow(l,[]), title('L')
% subplot(4,2,2), imshow(a,[]), title('a')
% subplot(4,2,3), imshow(b,[]), title('b')
% subplot(4,2,4), imshow(imageFraises,[]), title('rgb');
% subplot(4,2,5), imshow(fraisesR,[]), title('rouge')
% subplot(4,2,6), imshow(vertG,[]), title('vert')
% subplot(4,2,7), imshow(fraises,[]), title('rouge logical')
% subplot(4,2,8), imshow(vert, []), title('vert logical')


end
