function createImgDB()

lfwMatDBC = imageDatastore(fullfile('../lfw'), 'IncludeSubfolders',true,'LabelSource','foldernames');
lfwMatDBG = imageDatastore(fullfile('../lfw_gray'), 'IncludeSubfolders',true,'LabelSource','foldernames');
[lfwDB.labels, ~, lfwDB.labelMap] = unique(lfwMatDBG.Labels);
    
for i = 1:max(lfwDB.labelMap)
    labelFiles = lfwMatDBG.Files(lfwDB.labelMap == i);
    for j = 1:size(labelFiles,1)
        lfwDB.images{i,j} = imresize(imread(labelFiles{j}),[50 50]);
    end
end

lfwDB.lfwMatDBC = lfwMatDBC;
lfwDB.lfwMatDBG = lfwMatDBG;
save('lfwDB.mat', 'lfwDB');

end