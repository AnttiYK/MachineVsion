function pyr = laplace_pyramid(I, levels)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
%
% This function computes the laplacian pyramid of the image I.
% PARAMETERS:
% I: greyscale or rgb image as a double
% levels: number of levels in the pyramid
% OUTPUT:
% pyr: laplacian pyramid, cell array of length equal to levels
pyr = gauss_pyramid(I, levels);
for i = 1 : levels -1
    [r, c, x] = size(pyr{i});
    pyr{i} = pyr{i} - imresize(pyr{i + 1}, [r c]);
end
end

