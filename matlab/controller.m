% clear all;
lfwDB          = load('lfwDB.mat');
numberOfPeople = 430;


%% Neural net architecture 
layers = [
    imageInputLayer([50 50 1])
    
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
    
    fullyConnectedLayer(numberOfPeople)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm','MaxEpochs',5, ...
	'InitialLearnRate',0.01,'LearnRateDropFactor',0.1,...
    'LearnRateDropPeriod',5,'MiniBatchSize',16, ...
    'Plots','training-progress','Shuffle','every-epoch');

convnet = trainNetwork(lfwDB.images{1:100},layers,options);