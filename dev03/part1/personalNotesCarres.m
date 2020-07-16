% close/removes any squares below 4x4
b1 = strel('square', 4);
C = imopen(recImage, b1);

