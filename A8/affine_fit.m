function [M, t] = affine_fit(x, y)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% Estimates 2D affine transformation from point correspondences x <-> y so
% that y = M*x + t
% INPUT:
% x: 2xN matrix, points in first image
% y: 2xN matrix, points in second image
% OUTPUT:
% M: 2x2 matrix, linear part of affine transformation
% t: 2x1 vector, translation vector

[~,N] = size(x);
newDim = ones(1,N);
xHom = [x; newDim];
yHom = [y; newDim];
Mt = mrdivide(yHom ,xHom);
t= [Mt(1,N); Mt(2,N)];
M = [Mt(1,1), Mt(1,2); Mt(2,1), Mt(2,2)];
end