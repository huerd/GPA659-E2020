function [objProbabilitees, bkgProbabilitees] = calculerProbabilitesParPixel(image, masque)

% validation des entrees
if(size(image,1) ~= size(masque,1) || size(image,2) ~= size(masque,2))
    error('L''image et le masque doivent avoir la meme taille MxN size.');
end
[M,N,O] = size(image);

% normalisation des valeurs entre 0 et 1.0
if(max(image(:)) > 1.0)
    image = double(image);
end

% parametre
Nbins = 32; % nombre de classe par dimension (N en niveaux de gris, NxNxN en RGB)

% cette implementation ne fonctionne que pour les images en niveau de gris
% image = rgb2gray(image);

% calcul des histogrammes (nous utiliseront des boucle for pour faciliter la comprehension du code)
% objHist = zeros(Nbins,1,1); % les histogrammes sont en 1d pour une image en niveau de gris
% bkgHist = zeros(Nbins,1,1);

% color implementation
objHist = zeros(Nbins,Nbins,Nbins); 
bkgHist = zeros(Nbins,Nbins,Nbins);

for x=1:M
    for y=1:N
        % id = ceil(image(x,y) * (Nbins-1)) + 1;
% 
%         idR = ceil(image(x,y,1) * (Nbins-1)) + 1;
%         idG = ceil(image(x,y,2) * (Nbins-1)) + 1;
%         idB = ceil(image(x,y,3) * (Nbins-1)) + 1;
        
        % extract values from each color channel
        r = image(x,y,1);
        g = image(x,y,2);
        b = image(x,y,3);
        
        % get 3d coordinates relative to our 64x64 histogram (rounded)
        idR = ceil((Nbins-1)*r/255 + 1);
        idG = ceil((Nbins-1)*g/255 + 1);
        idB = ceil((Nbins-1)*b/255 + 1);

        if masque(x,y)
            % objHist(id) = objHist(id) + 1;
            objHist(idR, idG, idB) = objHist(idR, idG, idB) + 1;
        else
            % bkgHist(id) = bkgHist(id) + 1;
            bkgHist(idR, idG, idB) = bkgHist(idR, idG, idB) + 1;
        end
    end
end

sumBkgHist = sum(bkgHist(:))
sumObjHist = sum(objHist(:))
totalSum = sumBkgHist + sumObjHist
totalArea = M*N
assert(isequal(totalSum, totalArea),'Les histogrammes n''ont pas correctement compter tous les pixels')

% les histogrames sont normalises pour former une fonction de densite de probabilite
objPDF = objHist ./ sum(objHist(:));
bkgPDF = bkgHist ./ sum(bkgHist(:));

% on remplace les 0 par de toutes petites valeurs: rien ne devrait etre impossible!
histAlpha = 1e-6; % la probabilite minimale dans chaque classe de la fonction de densite de probabilites
objPDF = (1-histAlpha) .* objPDF + histAlpha/(Nbins);
bkgPDF = (1-histAlpha) .* bkgPDF + histAlpha/(Nbins);


% mapping entre les pixels et les classes de l'histogramme
sizeObjPDF = size(objPDF);

R = ceil((Nbins-1)*(image(:,:,1)-1)/255 + 1);
G = ceil((Nbins-1)*(image(:,:,2)-1)/255 + 1);
B = ceil((Nbins-1)*(image(:,:,3)-1)/255 + 1);

linearR = R(:);
linearG = G(:);
linearB = B(:);

idx = sub2ind(sizeObjPDF, R(:), G(:), B(:));

% id = ceil(image .* (Nbins-1)) + 1;
% idx = sub2ind(sizeObjPDF,id(:),id(:),id(:));


objProb = objPDF(idx);
bkgProb = bkgPDF(idx);

% Calcul des termes de regions pour chaque pixel
objProbabilitees = -log(reshape(objProb,M,N));
bkgProbabilitees = -log(reshape(bkgProb,M,N));

% optionellement: penaliser les bordures pour qu'elles soient arriere-plan
% w = max(max(objPDF(:)),max(bkgPDF(:)));
% b = min(min(objPDF(:)),min(bkgPDF(:)));
% objPDF(1,:) = w; objPDF(end,:) = w; objPDF(:,1) = w; objPDF(:,end) = w;
% bkgPDF(1,:) = b; bkgPDF(end,:) = b; bkgPDF(:,1) = b; bkgPDF(:,end) = b;
