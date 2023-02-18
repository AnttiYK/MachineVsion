function P=camcalibDLT(Xworld,Xim)
% name: Antti Yli-Kujala
% student number: e123107
% This function performs camera calibration using homogeneous least
% squares.
% INPUT:
%   Xworld, array of size Nx3: 3D cartesian coordinates
%   Xim, array of size Nx2: 2D cartesian coordinates
% OUTPUT:
%   P: projection matrix size 3x4

% Create the matrix A
[size_Xim, ~] = size(Xim);
A = zeros(2 * size_Xim, 12);
x = Xim(:,1);
y = Xim(:,2);
X = Xworld(:,1);
Y = Xworld(:,2);
Z = Xworld(:,3);
for i = 1:size_Xim
    j = 2 * i;
    A(j-1,:) = [0, 0, 0, 0, X(i), Y(i), Z(i), 1, -y(i)*X(i), -y(i)*Y(i), -y(i)*Z(i), -y(i)];
    A(j,:) = [X(i), Y(i), Z(i), 1, 0, 0, 0, 0, -x(i)*X(i), -x(i)*Y(i), -x(i)*Z(i), -x(i)];
end
% Perform homogeneous least squares fitting,
A = transpose(A) * A;
[v, ~] = eigs(A,1,'SM');
% reshape into projection matrix
v = transpose(v);
P = [v(1:4); v(5:8); v(9:12)];
end