%% ASSIGNMENT: IMAGE BLENDING
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
clear all, close all, clc

%% Load the images and convert to double
apple = im2double(imread("apple.jpeg"));
orange = im2double(imread("orange.jpeg"));

%% TODO: Create the masks mask_orange and mask_apple 
[r,c,x] = size(orange);
mask_orange = ones(size(orange));
mask_orange(1:r, 1:(c/2 - 1), :) = 0;
[r,c,x] = size(apple);
mask_apple = ones(size(apple));
mask_apple(1:r, c/2:c, :) = 0;

%% TODO: Perform simple blending
blend_simple = (orange .* mask_orange) + (apple .* mask_apple);

%% TODO: Extract the laplace pyramids of the images
levels = 20;

apple_laplace = laplace_pyramid(apple, levels);
orange_laplace= laplace_pyramid(orange, levels);

%% Reconstruct the apple image from the laplace pyramid and check that the error is small
rec = from_laplacian(apple_laplace);
max_error=max(abs(apple(:)-rec(:)))

%% Compute the gaussian pyramids of the masks
mask_orange_gauss = gauss_pyramid(mask_orange, levels);
mask_apple_gauss = gauss_pyramid(mask_apple, levels);

%% Combine each level of the pyramids
blended_pyramid = cell(1, levels);
for i = 1:levels
    blended_pyramid{i} = (apple_laplace{i} .* mask_apple_gauss{i}) + (orange_laplace{i} .* mask_orange_gauss{i});
end
%% Reconstruct the blended image from the new pyramid
blended = from_laplacian(blended_pyramid);
imshow(blended)
%% Visualize the results
figure;
subplot(221)
imshow(apple);
title('Apple')

subplot(222)
imshow(orange)
title('Orange');

subplot(223);
imshow(blend_simple);
title('Naive blending');

subplot(224);
imshow(blended)
title('Proper blending')