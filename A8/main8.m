% Author name: Antti Yli-Kujala
% Student number: e123107

clear all, close all, clc

load('points.mat');

[M, t] = affine_fit(X(:,1:end/3:end), Yaffine(:,1:end/3:end));

Yest = M*X+t;

figure(1)
subplot(221);
plot(X(1,:), X(2,:), 'b.');
title('original');

subplot(222);
plot(Yaffine(1,:), Yaffine(2,:), 'r.');
title('target');

subplot(223)
plot(Yest(1,:), Yest(2,:), 'k.');
title('transformed')


%%

H = homography_fit(X(:,1:end/4:end), Yhom(:,1:end/4:end));

Yest = H*[X; ones(1, size(X, 2))];
Yest = Yest(1:2,:)./Yest(3,:);

figure(2)
subplot(221);
plot(X(1,:), X(2,:), 'b.');
title('original');

subplot(222);
plot(Yhom(1,:), Yhom(2,:), 'r.');
title('target');

subplot(223)
plot(Yest(1,:), Yest(2,:), 'k.');
title('transformed')

%%
I1 = im2double(imread('building1.JPG'));
I2 = im2double(imread('building2.JPG'));
load('matches.mat')

H = ransac_homography(x1, x2);

panorama = make_panorama(I1, I2, H);

figure(3); subplot(121); imshow(I1); subplot(122); imshow(I2)
figure(4); imshow(panorama)

