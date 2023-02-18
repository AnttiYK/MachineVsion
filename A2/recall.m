function r = recall(predicted, gt)
%AUTHOR: Antti Yli-Kujala
%STUDENT NUMBER: e123107
% This function computes the recall of a classifier
% INPUT
% predicted: Nx1 binary array of predicted labels
% gt: Nx1 binary array of gt
% OUTPUT
% r: recall value

tp = 0;
fn = 0;
for i = 1 : length(predicted)
   if(predicted(i) == 1 && gt(i) == 1) 
       tp = tp + 1;
   elseif(predicted(i) == 0 && gt(i) == 1) 
       fn = fn + 1;
   end
end
r = tp / (tp + fn);
end