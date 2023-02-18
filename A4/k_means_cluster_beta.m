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
% Create C and add k random elements of X in it
[N, D] = size(X);
C = zeros([k, D]);
for i = 1 : k
    rand = randi(size(X, 1), 1);
    C(i,:) = X(rand,:);
end
labels = zeros([N, 1]); 
cnt = 0;
% default previous labels as ~ of labels so first while loop begins
prevl = ~labels;
%loop until max iterations is reached or when labels doesn't change
while(cnt < max_iter && all(prevl ~= labels))
    %set previous labels before its modified
    prevl = labels;
    % loop through X
    for i = 1 : N
        % variable telling the centroid with shortest distance
        % default to C(1)
        short = 1;
        shortD = pdist([X(i,:); C(1,:)],'euclidean');
        % for every element of x find out shortest distance from C
        for j = 2 : k
            if(pdist([X(i,:); C(j,:)], 'euclidean') <= shortD)
                short = j;
                shortD = pdist([X(i,:); C(j,:)]);
            end
        end
        %set label point to shortes cluster
        labels(i,1) = short; 
    end
    
    for i = 1 : k 
        idx = zeros(N, 1);
        idx(labels == i) = 1;
        for j = 1: D
            C(i,j) = mean(nonzeros(idx .* X(:,j)));
        end
    end
    cnt = cnt + 1;
end


end