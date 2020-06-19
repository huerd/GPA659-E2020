function [mouvementDetecte, movementParPixel] = detectionMouvement(image, modele) 
% Ce system de détection de mouvement donné en exemple 
    movementParPixel=(image-(modele.mu+modele.sigma)).^2;
    movementParPixel=movementParPixel>0.18;
    mouvementDetecte = sum(movementParPixel,'all') >= modele.T ;
end