%AUTHOR: Antti Yli-Kujala
%STUDENT NUMBER: e123107
clear all, close all, clc

% Simple k-means clustering
load('data1.mat');
[labels, C, cnt] = k_means_cluster(X, 2);

% extract the points belonging to each cluster
X1 = X(labels==1, :);
X2 = X(labels==2, :);

figure(1);
plot(X1(:,1), X1(:, 2), 'bo');
hold on;
plot(X2(:, 1), X2(:, 2), 'ro');
plot(C(:,1), C(:,2), 'kx', 'LineWidth', 10, 'MarkerSize', 4);
hold off
axis equal
grid on
%% K-means segmentation
I = im2double(imread('peppers.png'));

k = 7; %number of clusters

% TODO CREATE THE ARRAY X of size H*W x 3 from the image I
[H, W] = size(I);
X = reshape(I, [], 3);

[labels, C, cnt] = k_means_cluster(X, k);

% TODO: reshape the labels vector into an image of size XxW
L = reshape(labels, H, []); 

%% plotting
J = label2rgb(L, C);

figure(2)
subplot(121)
imshow(I)
subplot(122)
imshow(J)

%% PLOT SSD AND FIND ELBOW POINT

kmax = 20;

ssd = get_ssd(X, kmax);

figure(3)
plot(1:kmax, ssd);
xlabel('number of clusters')
ylabel('SSD');
grid on