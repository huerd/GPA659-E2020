% Fonction 5
% Retourne le nom de la fonction MATLAB (sans arguments) servant supprimer toutes les
% variables de votre espace de travail. Le type retourné est un 'vecteur de caractères' et
% non le type "string". Ces deux types de données distincts existent en MATLAB. Vous
% devez donc trouvez 2 informations dans l’aide en ligne : (1) quelle est le nom de la fonction
% MATLAB qui libère la mémoire de travail, et (2) comment retourne-t-on un vecteur de
% caractères en MATLAB 

% Resources  : https://www.mathworks.com/help/matlab/matlab_prog/fundamental-matlab-classes.html
function [output] = nomDeLaFonction()
    functionName = "clear"; % double quotations are strings
%     functionName = 'clear'; % single quotations are immediately char vectors
    output = convertStringsToChars(functionName);
end