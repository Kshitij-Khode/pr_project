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
        fprintf('mace_iter:%d\n', i);
    end
    lfwDB.images{i,end+1} = normMACE;
    save('../data/lfwDB.mat', 'lfwDB');
end
