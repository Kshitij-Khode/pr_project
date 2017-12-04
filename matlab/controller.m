clear all;
net = trainCNN(50,1000,30);

% test = imageDatastore(fullfile('../data/CASIA_temp'), 'IncludeSubfolders',true,'LabelSource','foldernames');
% [testData, ~] = splitEachLabel(test,15,'randomize');
% 
% predictedLabels = classify(net,testData);
% testLabels = testData.Labels;
% 
% accuracy = sum(predictedLabels == testLabels)/numel(testLabels)