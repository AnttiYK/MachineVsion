clear all, close all, clc
%AUTHOR: Antti Yli-Kujala
%STUDENT NUMBER: e123107


%% Using your code from assignment 3, retrain the NN (using dropout) and 
% for each class (smiling/non-smiling) find a correctly and incorrectly
% classified test image. Save your trained network in the file mdl5.mat and
% the four test images you have picked. Put the saved files in the same
% folder of this script.

% Had NN already saved from assignment 3. See A3 main3.m net2 for code.


%% Load the trained network and read images
load('mdl5.mat');
inputSize = [64, 64];
nonsmilingFN = imresize(imread('./images/nonsmilingFN.jpg'), inputSize);
nonsmilingTP = imresize(imread('./images/nonsmilingTP.jpg'), inputSize);
smilingFN = imresize(imread('./images/smilingFN.jpg'), inputSize);
smilingTP = imresize(imread('./images/smilingTP.jpg'), inputSize);

%% For each image, plot the heat map using LIME and GRAD-CAM, you can use
% the following code skeleton as help

figure(1)
sgtitle('LIME')
subplot(221)
% heat map 1
map1 = imageLIME(net2, nonsmilingFN, 'false');
imshow(nonsmilingFN)
hold on
imagesc(map1, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("non smiling false negative"))

subplot(222)
%heat map 2
map2 = imageLIME(net2, nonsmilingTP, 'true');
imshow(nonsmilingTP)
hold on
imagesc(map2, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("non smiling true positive"))

subplot(223)
% heatmap 3
map3 = imageLIME(net2, smilingFN, 'false');
imshow(smilingFN)
hold on
imagesc(map3, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("smiling false negative"))

subplot(224)
% heatmap 4
map4 = imageLIME(net2, smilingTP, 'true');
imshow(smilingTP)
hold on
imagesc(map4, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("smiling true positive"))


figure(2)
sgtitle('GRAD-CAM')
subplot(221)
% heat map 1
map1 = gradCAM(net2, nonsmilingFN, 'false');
imshow(nonsmilingFN)
hold on
imagesc(map1, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("non smiling false negative"))

subplot(222)
%heat map 2
map2 = gradCAM(net2, nonsmilingTP, 'true');
imshow(nonsmilingTP)
hold on
imagesc(map2, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("non smiling true positive"))

subplot(223)
% heatmap 3
map3 = gradCAM(net2, smilingFN, 'false');
imshow(smilingFN)
hold on
imagesc(map3, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("smiling false negative"))

subplot(224)
% heatmap 4
map4 = gradCAM(net2, smilingTP, 'true');
imshow(smilingTP)
hold on
imagesc(map4, 'AlphaData', 0.5);
colormap jet
colorbar
title(sprintf("smiling true positive"))

