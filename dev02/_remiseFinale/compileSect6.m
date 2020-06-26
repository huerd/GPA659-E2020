function [mvt] = compileSect6()
    clear
    clc
    %N represente le nombre dimage a analyser
    N=1200;
    if isfile('modele.mat')
        load('modele.mat');
    else
        modele=createModele(N);
    end
    mvt = zeros(1,N);
    
    for i = 1:N
        image = rgb2gray(im2double(imread(sprintf('./data/frame%d.jpg',i))));
        [mouvementDetecte, movementParPixel] = detectionMouvement(image, modele);
        T=sum(movementParPixel(:));
        mvt(i) = mouvementDetecte;
    end
    
end
%final = compileSect6;compare = etiquette-final;sum(compare>0)
