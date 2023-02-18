function H = homography_fit(x, y)
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
% Estimates 2D homograhy from point correspondences x <-> y so
% that w*[y; 1] = H*[x; 1]
% INPUT:
% x: 2xN matrix, points in first image
% y: 2xN matrix, points in second image
% OUTPUT:
% H 3x3 matrix, homography matrix
[~, size_x] = size(x);
A = zeros(2 * size_x, 9);
u = x(1,:)';
v = x(2,:)';
U = y(1,:)';
V = y(2,:)';
for i = 1:size_x
    j = 2 * i;
    A(j-1,:) = [u(i), v(i), 1, 0, 0, 0, -U(i)*u(i), -U(i)*v(i), -U(i)];
    A(j,:) = [0, 0, 0, u(i), v(i), 1, -V(i)*u(i), -V(i)*v(i), -V(i)];
end
% Perform homogeneous least squares fitting,
A = transpose(A) * A;
[v, ~] = eigs(A,1,'SM');
% reshape into projection matrix
v = transpose(v);
H = [v(1:3); v(4:6); v(7:9)];

end