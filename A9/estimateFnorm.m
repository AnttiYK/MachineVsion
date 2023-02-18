function F = estimateFnorm(x1,x2)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% This function estimates the fundamental matrix from point correspondences
% using the normalised 8 points algorithm
% INPUT:
% x1: 3xN matrix, each column has homogeneous coordinates of a point in the
%     first image
% x2: 3xN matrix, each column has homogeneous coordinates of a point in the
%     second image
% OUTPUT:
% F: 3x3 matrix, fundamental matrix


% Normalise each set of points so that the origin
% is at centroid and mean distance from origin is sqrt(2).
% normalise2dpts also ensures the scale parameter is 1.
[x1, T1] = normalise2dpts(x1);
[x2, T2] = normalise2dpts(x2);

% Use eight-point algorithm to estimate fundamental matrix F
[~, n] = size(x1);
for i = 1:n
    x1x = x1(1,i);
    x1y = x1(2,i);
    x2x = x2(1,i);
    x2y = x2(2,i);
    A(i,:) = [x1x*x2x, x1y*x2x, x2x, x1x*x2y, x1y*x2y, x2y, x1x, x1y, 1];
end
A = transpose(A) * A;
[f, ~] = eigs(A,1,'SM');
f = reshape(f, [], 3);
f = transpose(f);

% Enforce constraint that fundamental matrix has rank 2
[U,S,V] = svd(f);
S(3,3) = 0;
F = U*S*V';

% Denormalise back to original coordinates
F = T2' * F * T1;
F = -F;

end

