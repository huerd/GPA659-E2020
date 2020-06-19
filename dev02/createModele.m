function [modele] = createModele(n)
%CREATEMODELE Summary of this function goes here
%   Detailed explanation goes here
    modele = struct();
    for i = n:-1:1 %la boucle est inversée pour une question de performance
        image=rgb2gray(im2double(imread(sprintf('./data/frame%d.jpg',i))));
        f(:,:,i) = image;
    end
    modele.mu = mean(f,3);
    modele.sigma = std(f,0,3);
    modele.T=200;
    save('modele.mat','modele'); 
    %1200 0.7 0.3
end
