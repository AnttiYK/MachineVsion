function [p, r, AUC] = pr_curve(score, gt)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% This function returns two arrays containing precision and recall at
% different threshold values
% INPUT:
% score: Nx1 array containing classification scores
% gt: Nx1 array of groundtruth
% OUTPUT:
% p: array containing precision values, length equal to the number of
% unique elements in score
% r: array containing recall values, length equal to the number of
% unique elements in score
% AUC: Area Under Curve
instance_count = ones(length(score),1);
score_uniq = unique(score);
num_thresh = length(score_uniq);
qvals = (1:(num_thresh-1))/num_thresh;
thresh = [min(score) quantile(score,qvals)];
thresh = sort(unique(thresh),2,'descend');
total_target = sum(gt);
prec = zeros(length(thresh),1);
rec  = zeros(length(thresh),1);
for i = 1:length(thresh)
    idx     = (score >= thresh(i));
    rec(i)  = sum(gt(idx)) / total_target;
    prec(i) = sum(gt(idx)) / sum(instance_count(idx));
end
p = prec;
r= rec;
AUC = trapz(r, p);
end