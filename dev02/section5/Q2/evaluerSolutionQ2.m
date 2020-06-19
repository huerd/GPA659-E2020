function [ MSE ] = evaluerSolutionQ2( imageFiltree )
%EVALUERSOLUTION Cette fonction prend en paramètre l'image lena.jpg
%filtrée, puis affiche et retourne l'erreur quadratique moyenne 
%(Mean square error, ou MSE). Le MSE est une métrique permettant de
%quantifié l'erreur par rapport à une solution optimale.

% Exemple:
% f = imread('lena.jpg');
% h = ones(3) ./ 9;
% g = imfilter(f,h,'symmetric');
% erreur = evaluerSolutionQ2( g );

    if max(imageFiltree(:)) <= 1
        imageFiltree = uint8(imageFiltree *255);
    end
    
    load('solutionLena.mat');

    if(numel(imageFiltree) ~= numel(solution))
        error('La taille de l''image ne doit pas avoir changée!');
    end

    MSE = sum(sum((double(imageFiltree(:)) - double(solution(:))) .^2))/numel(imageFiltree);

    display(['Cette solution pour lena.jpg a une erreur quadratique moyenne de ' num2str(MSE)]);

end
