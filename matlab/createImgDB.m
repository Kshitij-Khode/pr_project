function createImgDB()

lfwMatDB = imageDatastore(fullfile('../lfw'), 'IncludeSubfolders',true,'LabelSource','foldernames');

for i = 1:size(lfwMatDB.Files,1)
    [lfwDB.labels, ~, lfwDB.indexLabelMap] = unique(lfwMatDB.Labels);
    lfwDB.test{i} = '123';
    lfwDB.imgs{i} = rgb2gray(imread(lfwMatDB.Files{i}));
end
save('lfwDB', 'lfwDB');

end