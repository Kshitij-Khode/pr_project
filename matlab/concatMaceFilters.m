function concatMaceFilters()
    load('../data/lfwDB.mat','lfwDB');
    for i = 1:size(lfwDB.images,1)
       imgCell = lfwDB.images(i,1:end-1);
       mace = lfwDB.images{end};
       for j = 1:size(imgCell,2)
           outputpath = lfwDB.path{i,j};
           imwrite(cat(2,mace,imgCell{j}),outputpath);
       end
       fprintf('concatMace:iter:%d\n',i);
    end
end
