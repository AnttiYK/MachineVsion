function [K, R, t] = KR_from_P(P)
% extracts the intrinsic parameters matrix K and camera pose [R, t] from
% the projection matrix P so that P = K*[R t].
KR = P(:,1:3);

[K,R] = rq(KR);
  
K = K / K(3, 3);

if K(1,1) < 0
D = diag([-1 -1 1]);
K = K * D;
R = D * R;
end

t = K\P(:,end);

return