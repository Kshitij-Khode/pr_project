function convNet = trainCNN(imgObj,imgDim,noOfLabels)

layers = [
    imageInputLayer(imgDim)
    
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

options = trainingOptions('sgdm','MaxEpochs',5, ...
	'InitialLearnRate',0.01,'LearnRateDropFactor',0.1,...
    'LearnRateDropPeriod',5,'MiniBatchSize',16, ...
    'Plots','training-progress','Shuffle','every-epoch');

convNet = trainNetwork(imgObj,layers,options);

end