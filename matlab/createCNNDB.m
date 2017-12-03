createDB()
computeMaceFilters()
concatMaceFilters()


function createDB()

    lfwMatDBC = imageDatastore(fullfile('../data/CASIA_gray_short'), 'IncludeSubfolders',true,'LabelSource','foldernames');
%     lfwMatDBG = imageDatastore(fullfile('../data/lfw_gray'), 'IncludeSubfolders',true,'LabelSource','foldernames');
    [lfwDB.labels, ~, lfwDB.labelMap] = unique(lfwMatDBC.Labels);

    for i = 1:max(lfwDB.labelMap)
        labelFiles = lfwMatDBC.Files(lfwDB.labelMap == i);
        for j = 1:size(labelFiles,1)
            lfwDB.images{i,j} = imresize(imread(labelFiles{j}),[50 50]);
            [filepath,filename,ext] = fileparts(labelFiles{j});
            lfwDB.path{i,j} = sprintf('%s/%s%s', filepath,filename,ext);
        end
    end

    lfwDB.lfwMatDBC = lfwMatDBC;
%     lfwDB.lfwMatDBG = lfwMatDBG;
    save('../data/lfwDB.mat', 'lfwDB');
end


function computeMaceFilters()
    load('../data/lfwDB.mat','lfwDB');
    % ----- Mace ----- %
    for i=1:size(lfwDB.images,1)
        pplImages = [];
        imgCell = lfwDB.images(i,:);
        for j=1:10
            pplImages(:,:,j) = imgCell{j};
        end
        u = ones(size(pplImages,3),1);
        macefilt = real(mace(pplImages,u));
        normMACE = macefilt - min(macefilt(:));
        normMACE = normMACE ./ max(normMACE(:));
        normMACE = normMACE .* 255;
        surf(macefilt);
        fprintf('mace_iter:%d\n', i);
    end
    lfwDB.images{i,end+1} = normMACE;
    save('../data/lfwDB.mat', 'lfwDB');
end

% ----- CNN ----- %
% convNet = trainCNN(lfwDB.lfwMatDBG,cnnImgDim,lfw4MinImgLabels);

function concatMaceFilters()
    load('../data/lfwDB.mat','lfwDB');
    for i = 1:size(lfwDB.images,1)
       imgCell = lfwDB.images(i,1:end-1);
       mace = lfwDB.images{end};
       for j = 1:size(imgCell,2)
           outputpath = lfwDB.path{i,j};
           imwrite(cat(2,mace,imgCell{j}),outputpath);
       end
    end
end





