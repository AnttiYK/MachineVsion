function [y1, y2] = surf_nn(surf1, surf2, x1, x2)
% Author: Antti Yli-Kujala
% Student number: e123107
% This function matches surf descriptors and returns the coordinates of the
% mutually nearest pairs sorted in decreasing similarity order. The surf
% descriptors are matched using nearest neighborhood with Euclidean
% distance.
% INPUT
% surf1: each row is a surf descriptor in the first picture.
% surf2: each row is a surf descriptor in the second picture.
% x1:    array of size mx2, each row contains the coordinates of the
%        corresponding surf descriptor in surf1.
% x2:    array of size nx2, each row contains the coordinates of the
%        corresponding surf descriptor in surf2.
% OUTPUT:
% y1, y2: arrays with same number of rows and 2 columns. Corresponding rows
%         contain the coordinates of mutually nearest surf descriptors.



%% Compute distance matrix
[m, ~] = size(x1);
[n, ~] = size(x2);
distmat = zeros(m,n);
for i = 1 : m
    distmat(i, :) = pdist2(surf1(i,:),surf2(:,:), 'euclidean');
end
%% Find mutually nearest pairs
pairs = zeros(m,3);
[minvals, c] = min(distmat,[],2);
for i = 1:m
    if(min(distmat(:,c(i))) == minvals(i))
        pairs(i,:) = [i,c(i),minvals(i)];
    end

end
%remove zero rows from pairs
pairs(all(~pairs,2),:)=[];
%% Sort matches
pairs = sortrows(pairs, 3);
y1 = x1(pairs(:,1),:);
y2 = x2(pairs(:,2),:);

end