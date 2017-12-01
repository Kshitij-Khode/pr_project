function createImgDB()

lfwMatStore = imageDatastore(fullfile('../lfw'), 'IncludeSubfolders',true,'LabelSource','foldernames');
for i = size(lfwMatStore.Files)
    [lfwStore.labels, ~, lfwStore.indexLabelMap]    = unique(lfwMatStore.Labels);
    lfwStore.labelImages{lfwStore.indexLabelMap(i)} = readimage(lfwMatStore, i);
end
store('imgDB', 'lfwStore');

end