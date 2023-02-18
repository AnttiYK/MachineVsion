function p = precision(predicted, gt)
%AUTHOR: Antti Yli-Kujala
%STUDENT NUMBER: e123107
% This function computes the precision of a classifier
% INPUT
% predicted: Nx1 binary array of predicted labels
% gt: Nx1 binary array of gt
% OUTPUT
% p: precision value

tp = 0;
fp = 0;
for i = 1:length(predicted)
   if(predicted(i) == 1 && gt(i) == 1) 
       tp = tp + 1;
   elseif(predicted(i) == 1 && gt(i) == 0) 
       fp = fp + 1;
   end
end
p = tp / (tp + fp);
end