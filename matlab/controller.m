clear all;
load('../data/lfwDB.mat');

cnnImgDim = [250 250 1];
maceImgDim = [50 50];
lfw4MinImgLabels = 430;

% ----- Mace ----- %
pplMaces = [];
for i=1:size(lfwDB.images,1)
    pplImages = [];
    imgCell = lfwDB.images(i,:);
    for j=1:size(imgCell,2)
        pplImages(:,:,j) = imgCell{j};
    end
    u = ones(size(pplImages,3),1);
    imwrite(mace(pplsImages,u),'zzz.png')
    fprintf('mace_iter:%d\n', i);
end

% ----- CNN ----- %
% convNet = trainCNN(lfwDB.lfwMatDBG,cnnImgDim,lfw4MinImgLabels);


for i = 1:size(lfwDB.images,1)
   pplImages = [];
   imgCell = lfwDB.images(i,1:end-1);
   mace = lfwDB.images(i,end-2:end-1);
   for j = 1:size(imgCell,2)
       imwrite(cat(2,mace,imgCell{j}),'img#%f.png',j);
   end
end