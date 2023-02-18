%% ASSIGNMENT 3
% AUTHOR: Antti Yli-Kujala
% STUDENT NUMBER: e123107
clear all, close all, clc

% NOTE: YOU MUST HAVE UNTARRED THE DATASET BEFORE RUNNING THIS CELL
% read labels
fid = fopen('./genki4k/labels.txt', 'r');
labels = fscanf(fid, '%d %f %f %f\n');
fclose(fid);
labels = labels(1:4:end) > 0;

% create image datastore
imds = imageDatastore('./genki4k/files');
imds.Labels = categorical(labels);
montage(imds.Files([1:5, end-4:end]));

% split into training and test data
numTrainFiles = 0.8;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%% TODO: convert imdsTrain and imdsTest to augmented image datastores, to ensure all pictures have the correct size (64x64) and are rgb

imdsTrain = augmentedImageDatastore([64, 64], imdsTrain, 'ColorPreprocessing', 'gray2rgb');
imdsValidation = augmentedImageDatastore([64, 64], imdsValidation, 'ColorPreprocessing', 'gray2rgb');

%% TODO CREATE YOUR NETWORK
layers = [

imageInputLayer([64, 64, 3]);

convolution2dLayer([5, 5], 32, 'Padding','same');
batchNormalizationLayer;
reluLayer;
maxPooling2dLayer(2, 'Stride', 2);


convolution2dLayer([5, 5], 32, 'Padding','same');
batchNormalizationLayer;
reluLayer;
maxPooling2dLayer(2, 'Stride', 2);

convolution2dLayer([5, 5], 32, 'Padding','same');
batchNormalizationLayer;
reluLayer;
maxPooling2dLayer(2, 'Stride', 2);

fullyConnectedLayer(128);
reluLayer;

fullyConnectedLayer(2);
softmaxLayer;
classificationLayer;
];

%% TRAINING OPTINS
options = trainingOptions('sgdm', ...
    'MaxEpochs',40, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');


%% TODO: TRAIN YOUR NETWORK
net = trainNetwork(imdsTrain,layers,options);

%% TODO: EVALUATE YOUR NETWORK ON THE VALIDATION DATA

% extracting groundtruth labels, a little clumsy for augmented image
% datastores, so I'll do it for you :)
data = readall(imdsValidation);
YValidation = data.response;
[YPred, scores] = classify(net,data);
accuracy = sum(YPred == YValidation)/numel(YValidation)


%% TODO PLOT PR-CURVE
[X, Y] = perfcurve(YValidation, scores(:,2), 'true', 'XCrit', 'tpr', 'YCrit', 'prec');
plot(X, Y);
xlabel('Recall')
ylabel('Precision')
xlim([0, 1])
ylim([0, 1])

%% TODO ADD DROPOUT LAYER
% you can either modify the parts above or copy
layers2 = [

imageInputLayer([64, 64, 3]);

convolution2dLayer([5, 5], 32, 'Padding','same');
batchNormalizationLayer;
reluLayer;
maxPooling2dLayer(2, 'Stride', 2);


convolution2dLayer([5, 5], 32, 'Padding','same');
batchNormalizationLayer;
reluLayer;
maxPooling2dLayer(2, 'Stride', 2);

convolution2dLayer([5, 5], 32, 'Padding','same');
batchNormalizationLayer;
reluLayer;
maxPooling2dLayer(2, 'Stride', 2);

fullyConnectedLayer(128);
reluLayer;
dropoutLayer(0.5);
fullyConnectedLayer(2);
softmaxLayer;
classificationLayer;
];

%%
%Train network
net2 = trainNetwork(imdsTrain,layers2,options);


%%
% TODO: EVALUATE YOUR NETWORK ON THE VALIDATION DATA
% extracting groundtruth labels, a little clumsy for augmented image
% datastores, so I'll do it for you :)
[YPred2, scores2] = classify(net2,imdsValidation);
accuracy2 = sum(YPred2 == YValidation)/numel(YValidation)

%% TODO PLOT PR-CURVE
[X2, Y2] = perfcurve(YValidation, scores2(:,2), 'true', 'XCrit', 'tpr', 'YCrit', 'prec');
plot(X2, Y2);
xlabel('Recall')
ylabel('Precision')
xlim([0, 1])
ylim([0, 1])

%%
hold all
plot(X,Y, 'b-', DisplayName='no dropout')
plot(X2,Y2,'r-', DisplayName='dropout')
legend
txt1 = [num2str(accuracy)];
txt2 = [num2str(accuracy2)];
annotation('textbox',[.9 .5 .1 .2], ...
    'String',txt1,'EdgeColor','none', 'Color','b')
annotation('textbox',[.9 .4 .1 .2], ...
    'String',txt2,'EdgeColor','none', 'Color','r')