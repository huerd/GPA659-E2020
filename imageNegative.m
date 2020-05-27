% Fonction 16
% Reçoit une image f (type uint8) en paramètre, la convertit en niveau de gris si nécessaire,
% applique une transformée qui génère une image négative (donc s=L-1-r, avec L étant le
% nombre de niveaux r la valeur du pixel d'origine et s la valeur du pixel inversé). La nouvelle
% image est retournée
function [g] = imageNegative(f)
    % converts to greyscale if RGB
    if (size(f,3) == 3)
        f = rgb2gray(f);
    end
    g=255 - f;
end

