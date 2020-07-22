% clean environment
clc;
close all; 
clear;
workspace; 

loadedFile = load('ImageMultispectrale.mat')

f = loadedFile.f;

class(f)
size(f)

g = f(:,:,[1 50 100]);
g = g ./ max(g,[],[1 2]); 

X = reshape(f,[],103); 
[~,X_acp,score] = pca(X);

fractionVarianceTotale = (score(1) + score(2) + score(3)) / sum(score)

g2 = reshape(X_acp(:,1:3),[size(f,1) size(f,2) 3]);
g2 = (g2 - min(g2,[],3)) ./ (max(g2,[],3) - min(g2,[],3));

idx = kmeans(X,5);
etiquette = reshape(idx,610,[]);
% ==============================================
subplot(1,4,1)
imshow(g)
title(['normalized 1,50, 100']);

subplot(1,4,2)
imshow(g2)
title(sprintf('fractionVarianceTotale= %0.2f%%',fractionVarianceTotale*100));
% 
subplot(1,4,3)
imshow(etiquette,[])
colormap('jet')
title(['groupes kmeans']);
% 
subplot(1,4,4)
imshow(f(:,:,60),[])
title(['une bande de l''image originale']);
