clear all, close all, clc
I1 = im2double(imread('boat1.png'));
I2 = im2double(imread('boat6.png'));

% extracting surf features
surf1 = detectSURFFeatures(I1);
x1 = surf1.Location;
f1 = extractFeatures(I1, surf1);

surf2 = detectSURFFeatures(I2);
x2 = surf2.Location;

f2 = extractFeatures(I2, surf2);

%% surf nn
[y1, y2] = surf_nn(f1, f2, x1, x2);

% Visualize 5 best matches
N = 5; % number of points to visualize
figure(1);
imshow([I1, I2]);
hold on
for ii=1:N
    plot(y1(ii, 1), y1(ii, 2), 'mo', 'MarkerSize', 20, 'Linewidth', 3);
    plot(size(I1,2)+y2(ii, 1), y2(ii, 2), 'mo', 'MarkerSize', 20, 'Linewidth', 3);
    plot([y1(ii, 1), size(I1,2)+y2(ii, 1)], [y1(ii, 2), y2(ii, 2)], 'c-');
end
hold off

%% surf nndr
[y1, y2] = surf_nndr(f1, f2, x1, x2);

% Visualize 5 best matches
N = 5; % number of points to visualize
figure(2);
imshow([I1, I2]);
hold on
for ii=1:N
    plot(y1(ii, 1), y1(ii, 2), 'mo', 'MarkerSize', 20, 'Linewidth', 3);
    plot(size(I1,2)+y2(ii, 1), y2(ii, 2), 'mo', 'MarkerSize', 20, 'Linewidth', 3);
    plot([y1(ii, 1), size(I1,2)+y2(ii, 1)], [y1(ii, 2), y2(ii, 2)], 'c-');
end
hold off
