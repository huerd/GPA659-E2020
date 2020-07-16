function [objProbabilitees, bkgProbabilitees] = calculerProbabilitesParPixel(image, masque)

% validation des entrées
if(size(image,1) ~= size(masque,1) || size(image,2) ~= size(masque,2))
    error('L''image et le masque doivent avoir la même taille MxN size.');
end
[M,N,~] = size(image);

% normalisation des valeurs entre 0 et 1.0
if(max(image(:)) > 1.0)
    image = double(image) ./ 255;
end

% paramètre
Nbins = 32; % nombre de classe par dimension (N en niveaux de gris, NxNxN en RGB)

% cette implémentation ne fonctionne que pour les images en niveau de gris
image = rgb2gray(image);

% calcul des histogrammes (nous utiliseront des boucle for pour faciliter la compréhension du code)
objHist = zeros(Nbins,1,1); % les histogrammes sont en 1d pour une image en niveau de gris
bkgHist = zeros(Nbins,1,1);
for x=1:M
    for y=1:N
        id = ceil(image(x,y) * (Nbins-1)) + 1;
        if masque(x,y)
            objHist(id) = objHist(id) + 1;
        else
            bkgHist(id) = bkgHist(id) + 1;
        end
    end
end
assert(isequal(sum(bkgHist) + sum(objHist),M*N),'Les histogrammes n''ont pas correctement compter tous les pixels')

% les histogrames sont normalisés pour former une fonction de densité de probabilité
objPDF = objHist / sum(masque(:));
bkgPDF = bkgHist / sum(~masque(:));

% on remplace les 0 par de toutes petites valeurs: rien ne devrait être impossible!
histAlpha = 1e-6; % la probabilité minimale dans chaque classe de la fonction de densité de probabilités
objPDF = (1-histAlpha) * objPDF + histAlpha/(Nbins);
bkgPDF = (1-histAlpha) * bkgPDF + histAlpha/(Nbins);

% mapping entre les pixels et les classes de l'histogramme
id = ceil(image .* (Nbins-1)) + 1;
idx = sub2ind(size(objPDF),id(:));

% Calcul des termes de regions pour chaque pixel
objProbabilitees = -log(reshape(objPDF(idx),M,N));
bkgProbabilitees = -log(reshape(bkgPDF(idx),M,N));

% optionellement: pénaliser les bordures pour qu'elles soient arrière-plan
% w = max(max(objPDF(:)),max(bkgPDF(:)));
% b = min(min(objPDF(:)),min(bkgPDF(:)));
% objPDF(1,:) = w; objPDF(end,:) = w; objPDF(:,1) = w; objPDF(:,end) = w;
% bkgPDF(1,:) = b; bkgPDF(end,:) = b; bkgPDF(:,1) = b; bkgPDF(:,end) = b;
