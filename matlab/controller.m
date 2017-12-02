clear all;
load('../data/lfwDB.mat');

cnnImgDim = [250 250 1];
maceImgDim = [50 50];
lfw4MinImgLabels = 430;

% ----- Mace ----- %
pplMaces = [];
for i=1:size(lfwDB.images,1)
    pplImages = [];
    imgCell = lfwDB.images(i,1:2);
    for j=1:size(imgCell,2)
        pplImages(:,:,j) = imgCell{j};
    end
    u = ones(size(pplImages,3),1);
    pplMaces(:,:,i) = mace(pplImages, u);
    fprintf('mace_iter:%d\n', i);
end

% ----- CNN ----- %
% convNet = trainCNN(lfwDB.lfwMatDBG,cnnImgDim,lfw4MinImgLabels);
