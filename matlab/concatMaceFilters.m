function concatMaceFilters()
    load('../data/faceData.mat','faceData');
    for i = 1:size(faceData.images,1)
       imgCell = faceData.images(i,1:end-1);
       mace = lfwDB.images{end};
       for j = 1:size(imgCell,2)
           outputpath = faceData.path{i,j};
           imwrite(cat(2,mace,imgCell{j}),outputpath);
       end
       fprintf('concatMace:iter:%d\n',i);
    end
end
