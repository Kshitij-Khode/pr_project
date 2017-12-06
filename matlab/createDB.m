function createDB()

    lfwMatDBC = imageDatastore(fullfile('../data/CASIAGray30_1000'), 'IncludeSubfolders',true,'LabelSource','foldernames');
    [lfwDB.labels, ~, lfwDB.labelMap] = unique(lfwMatDBC.Labels);

    for i = 1:max(lfwDB.labelMap)
        labelFiles = lfwMatDBC.Files(lfwDB.labelMap == i);
        for j = 1:size(labelFiles,1)
            lfwDB.images{i,j} = imresize(imread(labelFiles{j}),[50 50]);
            [filepath,filename,ext] = fileparts(labelFiles{j});
            lfwDB.path{i,j} = sprintf('%s/%s%s', filepath,filename,ext);
        end
        fprintf('createDB:iter:%d\n',i);
    end

    lfwDB.lfwMatDBC = lfwMatDBC;
    save('../data/faceData.mat', 'lfwDB');
end
