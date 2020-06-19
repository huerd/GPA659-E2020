%Create a black 30x30 image
f=zeros(30,30);

%With a white rectangle in it.
f(5:24,13:17)=1;

figure(1),imshow(f,'InitialMagnification', 'fit')

%Calculate the DFT. 
F=fft2(f);

%There are real and imaginary parts to F.
%Use the abs function to compute the magnitude 
%of the combined components.
F2=abs(F);

figure(2), imshow(F2,[], 'InitialMagnification','fit')

%To create a finer sampling of the Fourier transform, 
%you can add zero padding to f when computing its DFT 
%Also note that we use a power of 2, 2^256 
%This isbecause the FFT -Fast Fourier Transform - 
%is fastest when the image size has many factors.
F=fft2(f, 256, 256);

F2=abs(F);
figure(3), imshow(F2, []) 
%The zero-frequency coefficient is displayed in the 
%upper left hand  corner. To display it in the center,
%you can use the function fftshift.
F2=fftshift(F);

F2=abs(F2);       
figure(4),imshow(F2,[])