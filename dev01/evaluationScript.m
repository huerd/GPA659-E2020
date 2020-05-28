clear;
f = imread('cameraman.tif');
n = 1000;

A = creerColonne();
B = modifierElement4(A);
i = nombrePairsEntre178et2600();
B = initialiser34(A,i);
fct = nomDeLaFonction();
[A,B,C] = initABC();
estEgal = testMultiplication(A,B);
S = tailleResultatMultiplication(A,B);
B = changerColonne3x3(A);
B = doublerLigne3x3(A);
H = calculerHist(f);
C = extraireCentre9x9(ones(9));
F = Fibonacci();
S = calculerSomme(10^6);
g = translationCompressionHist(f);
g = imageNegative(f);
g = transformeeGamma(f);
g = egaliserHist(f);
image_out = redimensionnementPPV(f, 0.5);
reponse = question20Performance();

% Code to test each resize function
clear;
f = imread('cameraman.tif');
N = 50;
testResults = zeros(4,N);
for scale = 2:2:N*2
    tic
    redimensionnementPPV(f,scale);
    toc
    testResults(1,scale/2)= toc;
    
    tic
    imresize(f,scale,'nearest');
    toc
    testResults(2,scale/2)= toc;
    
    tic
    imresize(f,scale,'bicubic');
    toc
    testResults(3,scale/2)= toc;
    
    tic
    imresize(f,scale,'bilinear');
    toc
    testResults(4,scale/2)= toc;
end

% Computes the average of each row, where
% 1 - redimensionnementPPV
% 2 - nearest
% 3 - bicubic
% 4 - bilinear
averageResults = mean(testResults,2);
% Results from fastest to slowest : 


