function convNet = trainCNN(imgDim,noOfLabels,trainingNumFiles)

data = imageDatastore(fullfile('../data/CASIAGray30_1000'), 'IncludeSubfolders',true,'LabelSource','foldernames');
% data = imageDatastore(fullfile('../data/CASIAGray750_30'), 'IncludeSubfolders',true,'LabelSource','foldernames');
trainingNumFiles = round(0.9*trainingNumFiles);
[trainData,valData] = splitEachLabel(data,...
                trainingNumFiles,'randomize');
load('../data/inversemaceReal.mat','inversemaceReal');
% createDB()
% concatMaceFilters()


layers = [
    % imageInputLayer([imgDim imgDim 1])
    imageInputLayer([112 96 1])
    
    convolution2dLayer(imgDim,noOfLabels,'Name','maceFilters',...
       'Stride',32,'Padding',imgDim/2);
    
    dropoutLayer

    convolution2dLayer(3,64,'Stride',1,'Padding',1)
    batchNormalizationLayer
    reluLayer   

    maxPooling2dLayer(2,'Stride',2,'Padding',1)

    convolution2dLayer(3,128,'Stride',2,'Padding',1)
    batchNormalizationLayer
    reluLayer
    dropoutLayer

    maxPooling2dLayer(2,'Stride',2)

    fullyConnectedLayer(noOfLabels)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm','MaxEpochs',20, ...
    'InitialLearnRate',0.01,'LearnRateDropFactor',0.9,...
    'LearnRateDropPeriod',1,'L2Regularization',0.0005,...
    'miniBatchSize',4,...
    'ValidationData',valData,...
    'ValidationFrequency',30,...
    'Plots','training-progress');

%layers(2).Weights = computeMaceFilters(imgDim, noOfLabels);
layers(2).Weights = inversemaceReal;
convNet = trainNetwork(trainData,layers,options);

end