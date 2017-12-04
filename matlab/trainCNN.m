function convNet = trainCNN(imgDim,noOfLabels,trainingNumFiles)

data = imageDatastore(fullfile('../data/CASIA_temp'), 'IncludeSubfolders',true,'LabelSource','foldernames');
% data = imageDatastore(fullfile('../data/CASIAGray750_30'), 'IncludeSubfolders',true,'LabelSource','foldernames');
trainingNumFiles = round(0.9*trainingNumFiles);
[trainData,valData] = splitEachLabel(data,...
                trainingNumFiles,'randomize');

% createDB()
% computeMaceFilters()
% concatMaceFilters()

net = vgg16;
netLayers = net.Layers;
netLayers(1) = imageInputLayer([imgDim 2*imgDim 1]);
netLayers(2) = convolution2dLayer(3,64);
netLayers(39) = fullyConnectedLayer(noOfLabels);

layers = [
    imageInputLayer([imgDim 2*imgDim 1])
%     imageInputLayer([112 96 1])

    convolution2dLayer(3,20,'Name','splitLayer','Stride',1)
    dropoutLayer

    convolution2dLayer(5,12,'Stride',1,'Padding',1)
    batchNormalizationLayer
    reluLayer   

    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(4,25,'Stride',1,'Padding',0)
    batchNormalizationLayer
    reluLayer
    dropoutLayer

    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,32,'Stride',2,'Padding',1)
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(noOfLabels)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm','MaxEpochs',20, ...
    'InitialLearnRate',0.01,'LearnRateDropFactor',0.9,...
    'LearnRateDropPeriod',1,'L2Regularization',0.0005,...
    'ValidationData',valData,...
    'ValidationFrequency',30,...
    'Plots','training-progress');

convNet = trainNetwork(trainData,netLayers,options);

end