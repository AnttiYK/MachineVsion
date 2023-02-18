function H = ransac_homography(x1, x2, t, p)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% Estimates 2D homograhy in a RANSAC loop from point correspondences 
% x <-> y so that w*[y; 1] = H*[x; 1]
% INPUT:
% x1: 2xN matrix, points in first image
% x2: 2xN matrix, points in second image
% t: threshold to determine inliers
% p: probability to pick an outlier free sample at least once
% OUTPUT:
% H 3x3 matrix, homography matrix
if nargin < 4
    p = 0.999;
end

if nargin < 3
    t = 1;
end

[~, N] = size(x1);
n = 4;
iters = 1;
bestCount = -1;
x1inliers = [];
x2inliers = [];
i = 0;
while i < iters
%for i = 1 : iters
   randInd = randi(N, 1, n);
   x1points = x1(:,randInd);
   x2points = x2(:,randInd);
   A = homography_fit(x1points, x2points);
   newdim = ones(1,N);
   x1temp = [x1; newdim];
   x1temp = mtimes(A, x1temp);
   x1temp = x1temp(1:2, :) ./ x1temp(3,:);
   dist = zeros(N,1);
   x1temp = transpose(x1temp);
   x2temp = transpose(x2);
   for j = 1 : N
       dist(j,:) = (pdist2(x2temp(j,:), x1temp(j,:)))^2;
   end
   dist = (dist <= t);
   if sum(dist) > bestCount
        x1inliers = x1(:,dist == 1);
        x2inliers= x2(:,dist == 1);
        bestCount = sum(dist);
        outlierRatio = sum(dist == 0) / N;
        iters = round(log10(1-p)) / (log10(1-(1-outlierRatio)^n));
   end
   i = i + 1;
end

H = homography_fit(x1inliers, x2inliers);
end