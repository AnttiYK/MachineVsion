function ssd = get_ssd(X, kmax)
%AUTHOR: Antti Yli-Kujala
%STUDENT NUMBER: e123107
% This function performs k-means clustering for k=1:kmax and stores the
% SSD value for each k into the array ssd
% INPUT
% X: NxD matrix, data points, each row is a point in D-dimensional space
% kmax: maximum number of clusters
% OUTPUT
% ssd: array of length kmax containing the SSD values
ssd = zeros(kmax);
[N, D] = size(X);
for i = 1:kmax
    sd = 0;
    [labels, C, cnt] = k_means_cluster(X, i);
    for j = 1 : N
        y = labels(j,1);
        sd = sd + (pdist([X(j,:); C(y,:)]))^2;
    end
    ssd(i) = sd;
end
end