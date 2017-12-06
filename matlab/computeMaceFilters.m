function [maceReal] = computeMaceFilters(imgDim,numFilters)
    load('../data/faceData.mat','lfwDB');
    figure;
    % ----- Mace ----- %
    maceOriginal = zeros(imgDim,imgDim,1,numFilters);
    maceReal = zeros(imgDim,imgDim,1,numFilters);
    maceAbs = zeros(imgDim,imgDim,1,numFilters);
    inversemaceOriginal = zeros(imgDim,imgDim,1,numFilters);
    inversemaceReal = zeros(imgDim,imgDim,1,numFilters);
    inversemaceAbs = zeros(imgDim,imgDim,1,numFilters);
    for i=1:size(lfwDB.images,1)
        pplImages = [];
        imgCell = lfwDB.images(i,:);
        for j=1:30
            pplImages(:,:,j) = imgCell{j};
        end
        u = ones(size(pplImages,3),1);
        maceOriginal(:,:,1,j) = mace(pplImages,u);
        maceReal(:,:,1,j) = real(maceOriginal(:,:,1,j));
        maceAbs(:,:,1,j) = real(maceOriginal(:,:,1,j));
        inversemaceOriginal(:,:,1,j) = ifft2(maceOriginal(:,:,1,j));
        inversemaceReal(:,:,1,j) = real(inversemaceOriginal(:,:,1,j));
        inversemaceAbs(:,:,1,j) = abs(inversemaceOriginal(:,:,1,j));
        fprintf('mace_iter:%d\n', i);
    end
    save('../data/maceOriginal.mat', 'maceOriginal');
    save('../data/maceReal.mat', 'maceReal');
    save('../data/maceAbs.mat', 'maceAbs');
    save('../data/inversemaceOriginal.mat', 'inversemaceOriginal');
    save('../data/inversemaceReal.mat', 'inversemaceReal');
    save('../data/inversemaceAbs.mat', 'inversemaceAbs');


end
