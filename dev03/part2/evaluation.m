for i = 1:14
f = imread(sprintf('trbn%d.jpg',i));
[x, y, c] = trouverTrombones(f);
% affichage du “ground truth”
load(sprintf('trbn%d.mat',i));
figure(i)
imshow(f)
hold('on');
scatter([reponse.y],[reponse.x],32,'red','filled'); text([reponse.y]+10,[reponse.x], {reponse.couleur},'FontSize',18); hold('off');
    % affichage de votre solution
% ...
end