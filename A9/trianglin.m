function X = trianglin(P1,P2,x1,x2)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% Triangulates the point X corresponding to the 2D points x1 and x2.
% Inputs:
% P1 and P2 3x4 matrices, projection matrices for both images
% x1 and x2 vectors of length 2, euclidean coordinates of image points
% OUTPUT:
% X column vector of length 3, euclidean coordinates of X
A = [P1(3,:)*x1(1) - P1(1,:);
    P1(3,:)*x1(2) - P1(2,:);
    P2(3,:)*x2(1) - P2(1,:);
    P2(3,:)*x2(2) - P2(2,:)];
for i = 1:4
    A(i,:) = A(i,:) / norm(A(i,:));
end
[~,~,point] = svd(A);
point = point(:,end);
X = [point(1)/point(4);
    point(2)/point(4);
    point(3)/point(4)];
end
