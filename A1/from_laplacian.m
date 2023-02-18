function img = from_laplacian(pyr)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% 
% This function reconstructs the image from a laplacian pyramid
% PARAMETERS:
% pyr: laplacian pyramid
% OUTPUT:
% img: reconstructed image from the laplace pyramid

for p = length(pyr)-1:-1:1
    [r, c, x] = size(pyr{p});
    pyr{p} = pyr{p} + imresize(pyr{p+1}, [r c]);
end
img = pyr{1};
end