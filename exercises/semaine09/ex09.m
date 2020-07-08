image = imread('peppers.png');
figure(1), imshow(image);
doubleImage = double(image);

% generate 3d histogram of 64x64x64 (R x G x B)
histogramme3d = zeros(64,64,64);

% get the size and number of channels
[m, n, numColorChannels] = size(doubleImage);

% seperate the channels
channelR = doubleImage(:,:,1);
channelG = doubleImage(:,:,2);
channelB = doubleImage(:,:,3);

for x = 1:m
    for y = 1:n
        % extract values from each color channel
        r = doubleImage(x,y,1);
        g = doubleImage(x,y,2);
        b = doubleImage(x,y,3);
        
        % get 3d coordinates relative to our 64x64 histogram (rounded)
        idR = ceil(63*r/255 + 1);
        idG = ceil(63*g/255 + 1);
        idB = ceil(63*b/255 + 1);
        
        % increment +1 based on previously found coordinates
        histogramme3d(idR, idG, idB) = histogramme3d(idR, idG, idB) + 1;
    end
end

% verify that the number of points in our 3dhisto == mxn 
% of our image (should be true)
booleanResult = isequal(sum(histogramme3d(:)), m * n);

% generate 
[Y,X,Z] = meshgrid(1:64,1:64,1:64);

% using the freq of each color point, generate size of each point
S = histogramme3d ./ max(histogramme3d(:)) * 1000;

% filter points
filtre = S > 0;
X = X(filtre);
Y = Y(filtre);
Z = Z(filtre);
S = S(filtre);

% generate color points (where index represents the color)
C = [X(:) Y(:) Z(:)]/64;

% show 3d histogram
figure(2), scatter3(X(:), Y(:), Z(:), S(:), C,'filled')

