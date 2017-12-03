 data = imageDatastore(fullfile('../data/CASIA_gray_short'), 'IncludeSubfolders',true,'LabelSource','foldernames');

trainCNN(data,50,8);


function convNet = trainCNN(data,imgDim,noOfLabels)

    trainingNumFiles = 3;
    rng(1) % For reproducibility
    [trainData,valData] = splitEachLabel(data,...
                    trainingNumFiles,'randomize');

    layers = [
        imageInputLayer([2*imgDim imgDim 1])

        convolution2dLayer(3,20,'Name','splitLayer','Stride',1)
        dropoutLayer(0.25)

        convolution2dLayer(5,12,'Stride',1,'Padding',1)
        batchNormalizationLayer
        reluLayer   

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(4,25,'Stride',1,'Padding',0)
        batchNormalizationLayer
        reluLayer   

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

    onesMatrix = ones(2*imdDim,imgDim);
    firstLayerWeights = [imgDim,imgDim,2,onesMatrix];
    splitLayer.Weights = (firstLayerWeights);
    splitLayer.setLearnRateFactor(0);
    convNet = trainNetwork(trainData,layers,options);

end