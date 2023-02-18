function pyr = gauss_pyramid(I, levels)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
%
% This function computes the gaussian pyramid of the image I.
% PARAMETERS:
% I: greyscale or rgb image as a double
% levels: number of levels in the pyramid
% OUTPUT:
% pyr: gaussian pyramid, cell array of length equal to levels

pyr = cell(1,levels);
pyr{1} = im2double(I);
for p = 2:levels
    I_blurred = imgaussfilt(pyr{p-1});
    pyr{p} = imresize(I_blurred, 0.5);
end
end