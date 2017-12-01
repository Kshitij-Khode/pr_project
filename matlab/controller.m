clear all;
load('../data/lfwDB.mat');

cnnImgDim = [250 250 1];
maceImgDim = [50 50];
lfw4MinImgLabels = 430;

% maceFilts = [];
% for i=1:max(lfwDB.indexLabelMap)
%     u = ones(sum(lfwDB.indexLabelMap == i), 1);
% end    
convNet = trainCNN(lfwDB.lfwMatDBG,cnnImgDim,lfw4MinImgLabels);
