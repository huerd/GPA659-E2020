
# imfilter
https://www.mathworks.com/help/images/ref/imfilter.html
g = imfilter(originalImage, mask, paddin_option, output_size, filtering_mode)

Padding Options

numeric scalar, X
--
Input array values outside the bounds of the array are assigned the value X. When no padding option is specified, the default is 0.

'symmetric'
--
Input array values outside the bounds of the array are computed by mirror-reflecting the array across the array border.

'replicate'
--
Input array values outside the bounds of the array are assumed to equal the nearest array border value.

'circular'
--
Input array values outside the bounds of the array are computed by implicitly assuming the input array is periodic.
Output Size

'same'
--
The output array is the same size as the input array. This is the default behavior when no output size options are specified.

'full'
--
The output array is the full filtered result, and so is larger than the input array.
Correlation and Convolution Options

'corr'
--
imfilter performs multidimensional filtering using correlation, which is the same way that filter2 performs filtering. When no correlation or convolution option is specified, imfilter uses correlation.

'conv'
--
imfilter performs multidimensional filtering using convolution.

# fspecial()
https://www.mathworks.com/help/images/ref/fspecial.html#d120e69837

h = fspecial(type)
h = fspecial('average',hsize)
h = fspecial('disk',radius)
h = fspecial('gaussian',hsize,sigma)
h = fspecial('laplacian',alpha)
h = fspecial('log',hsize,sigma)
h = fspecial('motion',len,theta)
h = fspecial('prewitt')
h = fspecial('sobel')

# use double over 8uint

# nlfilter
 https://www.mathworks.com/help/images/ref/nlfilter.html


# colfilt
 https://www.mathworks.com/help/images/ref/colfilt.html

g = colfilt(f, [m n], ‘sliding’, @fun, parameters)

g est évidemment l’image résultante
f est l’image originale
[m n] spécifie la taille du voisinage à considérer, la taille du filtre
‘sliding’ indique que le procédé consiste à glisser le filtre sur l’image
@fun est la fonction de filtrage non-linéaire que nous désirons appliquer
parameters est la liste des paramètres requis par la fonction @fun

# padarray
fp = padarray(f, [r c], method, direction)
fp est évidemment l’image tamponnée résultante
f est l’image originale
[r c] indique le nombre de rangs et de colonnes désiré pour le tamponnage.

method
0 | numeric scalar | 'circular' | 'replicate' | 'symmetric' | string scalar | character vector | missing
    Numeric scalar — Pad array with elements of constant value. The default pad value of numeric and logical images is 0.

    'circular' — Pad with circular repetition of elements within the dimension.

    'replicate' — Pad by repeating border elements of array.

    'symmetric' — Pad with mirror reflections of the array along the border.

direction — Direction to pad array
'both' (default) | 'post' | 'pre'

Direction to pad array along each dimension, specified as one of the following values:

'both'
--
Pads before the first element and after the last array element along each dimension.

'post'
--
Pad after the last array element along each dimension.

'pre'
--
Pad before the first array element along each dimension. 

# gmean can be defined in a file or in an anonymous function
gmean = @(A) uint8(prod(double(A)) .^ (1 / size(A,1)));



# prod - Product of array elements
https://www.mathworks.com/help/matlab/ref/prod.html

B = prod(A)
B = prod(A,'all')
B = prod(A,dim)
B = prod(A,vecdim)
B = prod(___,outtype)
B = prod(___,nanflag)

B = prod(A) returns the product of the array elements of A.

    If A is a vector, then prod(A) returns the product of the elements.

    If A is a nonempty matrix, then prod(A) treats the columns of A as vectors and returns a row vector of the products of each column.

    If A is an empty 0-by-0 matrix, prod(A) returns 1.

    If A is a multidimensional array, then prod(A) acts along the first nonsingleton dimension and returns an array of products. The size of this dimension reduces to 1 while the sizes of all other dimensions remain the same.

prod computes and returns B as single when the input, A, is single. For all other numeric and logical data types, prod computes and returns B as double.

# ordfilt2
2-D order-statistic filtering

g = ordfilt2(f, order, domain, boundary_option)

g est évidemment l’image résultante
f est l’image originale
order est « l’ordre » ou le « rang » de l’élément sélectionné dans l’ensemble des voisins
domain est la spécification des éléments voisins que nous voulons considérer
boundary_option prend en charge le tamponnage de l’image

B = ordfilt2(A,order,domain)
B = ordfilt2(A,order,domain,S)
B = ordfilt2(___,padopt)

B = ordfilt2(A,order,domain) replaces each element in A by the orderth element in the sorted set of neighbors specified by the nonzero elements in domain.

B = ordfilt2(A,order,domain,S) filters A, where ordfilt2 uses the values of S corresponding to the nonzero values of domain as additive offsets. You can use this syntax to implement grayscale morphological operations, including grayscale dilation and erosion.

B = ordfilt2(___,padopt) filters A, where padopt specifies how ordfilt2 pads the matrix boundaries.

# ceil
Round toward positive infinity

Y = ceil(X) rounds each element of X to the nearest integer greater than or equal to that element.

Y = ceil(t) rounds each element of the duration array t to the nearest number of seconds greater than or equal to that element.

Y = ceil(t,unit) rounds each element of t to the nearest number of the specified unit of time greater than or equal to that element.

# medfilt2
2-D median filtering
g = medfilt2(f, [m n], boundary_option)

# fftshift(F)
Shift zero-frequency component to center of spectrum

Y = fftshift(X)
Y = fftshift(X,dim)

Y = fftshift(X) rearranges a Fourier transform X by shifting the zero-frequency component to the center of the array.

    If X is a vector, then fftshift swaps the left and right halves of X.

    If X is a matrix, then fftshift swaps the first quadrant of X with the third, and the second quadrant with the fourth.

    If X is a multidimensional array, then fftshift swaps half-spaces of X along each dimension.

# fft2
2-D fast Fourier transform

Y = fft2(X)
Y = fft2(X,m,n)

Y = fft2(X) returns the two-dimensional Fourier transform of a matrix using a fast Fourier transform algorithm, which is equivalent to computing fft(fft(X).').'. If X is a multidimensional array, then fft2 takes the 2-D transform of each dimension higher than 2. The output Y is the same size as X.

Y = fft2(X,m,n) truncates X or pads X with trailing zeros to form an m-by-n matrix before computing the transform. Y is m-by-n. If X is a multidimensional array, then fft2 shapes the first two dimensions of X according to m and n.

# ifftshift
to decentralize

# ifft2
inverse of fft2

# meshgrid
2-D and 3-D grids

[X,Y] = meshgrid(x,y)
[X,Y] = meshgrid(x)
[X,Y,Z] = meshgrid(x,y,z)
[X,Y,Z] = meshgrid(x)

[X,Y] = meshgrid(x,y) returns 2-D grid coordinates based on the coordinates contained in vectors x and y. X is a matrix where each row is a copy of x, and Y is a matrix where each column is a copy of y. The grid represented by the coordinates X and Y has length(y) rows and length(x) columns.

[X,Y] = meshgrid(x) is the same as [X,Y] = meshgrid(x,x), returning square grid coordinates with grid size length(x)-by-length(x).


[X,Y,Z] = meshgrid(x,y,z) returns 3-D grid coordinates defined by the vectors x, y, and z. The grid represented by X, Y, and Z has size length(y)-by-length(x)-by-length(z).

[X,Y,Z] = meshgrid(x) is the same as [X,Y,Z] = meshgrid(x,x,x), returning 3-D grid coordinates with grid size length(x)-by-length(x)-by-length(x).
