clear all, close all, clc

% To try a color image, you can use e.g. "peppers.png"
% To try a grayscale image, you can use e.g. "cameraman.tif"
I = imread("cameraman.tif");

% a couple of homographies you can play with
H = [0.9638   -0.0960   52.5754;
    0.2449    1.3808  -17.0081;
   -0.0001    0.0013    1.0000];

H1 = [0.8505   -0.2906    2.0000
    0.8515    0.8899    3.0000
    0.0010    0.0020    1.0000];


J = apply_homography(I, H1);

figure(1);
imshow(I);
title('original');

figure(2);
imshow(J);
title('apply\_homography');

% compare to matlab built-in function
tform = projective2d(H1');
J1 = imwarp(I, tform);

figure(3)
imshow(J1);
title('imwarp');
