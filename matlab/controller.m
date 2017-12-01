% clear all;
load('lfwDB.mat');

lfw4MinImgLabels = 430;
lfwDB = imageDatastore(fullfile('../lfw_gray'), 'IncludeSubfolders',true,'LabelSource','foldernames');
lfwImgDim = [50 50 1];

convNet = trainCNN(lfwDB,lfwImgDim,lfw4MinImgLabels);