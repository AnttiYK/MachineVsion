function [R, Q] = rq(A)
% computes the RQ decomposition of the matrix A and imposes Q to have
% positive determinant.

P = eye(size(A));
P = P(end:-1:1, :);
[Q, R] = qr(A'*P);

R = P*R'*P;
Q = P*Q';

if det(Q)<0
  R(:,1) = -R(:,1);
  Q(1,:) = -Q(1,:);
end
end