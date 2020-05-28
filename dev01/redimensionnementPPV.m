function [ image_out ] = redimensionnementPPV(image_in, facteur )
    % seule les images en niveau de gris sont acceptées
    if size(image_in,3) ~= 1
        warning('L''image doit être en niveau de gris'); 
        image_in = rgb2gray(image_in);
    end
    % taille de l'image d'entrée
    [m, n] = size(image_in);
    % Calcul de la taille de l'image de sortie
    n1 = floor(n*facteur);
    m1 = floor(m*facteur);
    image_out = zeros(m1, n1, 'uint8');
    % x_out et y_out sont les coordonnées dans l'image de sortie
    % vous devez calculer x_in et y_in (coordonnées dans l'image d'entrée) 
    % puis copier la valeur du pixel dans image_in vers image_out
    for y_out=1:n1
        for x_out=1:m1
            % get normalized xy from enalarged xy
            normalizedY = y_out/n1;
            normalizedX = x_out/m1;
            % Calcul des coordonnée en xy dans l'image d'entrée 
            originalX = normalizedX*m;
            originalY = normalizedY*n;
            % Copier le pixel de image_in vers image_out  
            if (originalX > 1 && originalY > 1)
                image_out(x_out, y_out) = image_in(floor(originalX), floor(originalY));
            end
        end
    end
end