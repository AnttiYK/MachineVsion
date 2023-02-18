%% ASSIGNMENT 7
% name: Antti Yli-Kujala
% student number: e123107
% load data
clear all, close all, clc

im1=imread('im1.jpg');
im2 = imread('im2.jpg');
load('points.mat');

figure(1);imshow(im1);hold on
plot(x1(:,1),x1(:,2),'c+','MarkerSize',10);
labels={'a','b','c','d','e','f','g','h'};
for i=1:length(x1)
    ti=text(x1(i,1),x1(i,2),labels{i});
    ti.Color='cyan';
    ti.FontSize=20;
end

figure(2);imshow(im1);hold on
plot(x2(:,1),x2(:,2),'c+','MarkerSize',10);
labels={'a','b','c','d','e','f','g','h'};
for i=1:length(x1)
    ti=text(x2(i,1),x2(i,2),labels{i});
    ti.Color='cyan';
    ti.FontSize=20;
end

%% CALIBRATE CAMERAS
P1 = camcalibDLT(X, x1)

P2 = camcalibDLT(X, x2)

%% Check the results by projecting the world points with the estimated P
newDim = ones(8,1);
Xhom = [X newDim]; % convert X to homogeneous coordinates
x1proj = mtimes(P1, transpose(Xhom));  % project the 3D points to the first image using P1
% convert to cartesian coordinates
x1proj = transpose(x1proj);
x1proj(:,1) = x1proj(:,1) ./ x1proj(:,3);
x1proj(:,2) = x1proj(:,2) ./ x1proj(:,3);
x1proj(:,3) = [];

x2proj = mtimes(P2, transpose(Xhom)); % project the points to the second image using P2
% convert to cartesian coordinates
x2proj = transpose(x2proj);
x2proj(:,1) = x2proj(:,1) ./ x2proj(:,3);
x2proj(:,2) = x2proj(:,2) ./ x2proj(:,3);
x2proj(:,3) = [];

figure(1);
for i=1:8
    plot(x1proj(:,1), x1proj(:,2) ,'rx','MarkerSize',15);
end
title('Cyan: manually located points  Red: projected points')

figure(2)
for i=1:8
    plot(x1proj(:,1), x1proj(:,2) ,'rx','MarkerSize',15);
end
title('Cyan: manually located points  Red: projected points')

%% intrinsic and extrinsic camera parameters K,R,t can be extracted from P

[K1, R1, t1] = KR_from_P(P1)
[K2, R2, t2] = KR_from_P(P2)