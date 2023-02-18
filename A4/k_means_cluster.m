function [labels, C, cnt] = k_means_cluster(X, k, max_iter)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% Thi function performs k-means clustering on data in X using k clusters
% INPUT
% X: NxD matrix. Each row is a point of a D-dimensional vector space, N
%    points in total
% k: number of clusters (positive integer)
% max_iter: (optional) maximum number of iterations
%
% OUTPUT
% labels: Nx1 column vector, containing values in the range 1:k. Each
%         element tells the cluster of the corresponding row in X, e.g. if
%         labels(i)==3 then X(i,:) belongs to the third cluster
%
% C: kxD matrix containing the centroids of the clusters, one per row.
%    For example C(1,:) corresponds to the centroid of the first cluster
%
% cnt: number of iterations done (can be useful for debugging)

if nargin < 3
    max_iter = 500; % use maximum 500 iterations by defaults
end
[N, D] = size(X); % number of elements in X and their dimensions
rand = randperm(N,k); % k random elements from X
C = X(rand,:); % initializing C with random elements of X
labels = zeros(N,1); %initialize labels
prevl = ~labels; % set previous labels to be ~labels so while loop begins
cnt = 0; % initialize cnt
while(cnt < max_iter && all(labels ~= prevl)) % runs as long as max iter is reached or labels doesnt change
    prevl = labels; % prevl equals labels before its modified
    for i = 1 : N % loop through X
        dist = zeros(k,1); % array for distances
        for j = 1 : k
            dist(j) = norm(X(i,:)-C(j,:)); % count distance from element of X to all points in C
        end
        [~, clusterP] = min(dist); % get index of shortest distance wich 
        labels(i) = clusterP; % set label to be the index
    end
    C = zeros(k, D); % re initialize C
    for i = 1 : k 
        C(i,:) = mean(X(labels == i,:)); % set C(i) equal to mean values of X elements that have corresponding label
    end
    cnt = cnt +1; % increment cnt
end
end