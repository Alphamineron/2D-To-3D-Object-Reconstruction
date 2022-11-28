function [XTrain, YTrain, XValidation, YValidation] = createTrainValidation()
    path = "DiLiGenT/pmsData";
    dirNames = dir(path);
    dirNames(1) = [];
    dirNames(1) = [];
    totalDirs = length(dirNames);
    randIdx = randperm(totalDirs);
    XTrain = [];
    YTrain = [];
    for i = 1:totalDirs/2
        idx = randIdx(i);
        [x, y] = loadData(dirNames(idx).name);
        XTrain = cat(4, XTrain, x);
        YTrain = cat(1, YTrain, y);
    end
    XValidation = [];
    YValidation = [];
    for i = totalDirs/2+1:totalDirs
        idx = randIdx(i);
        [x, y] = loadData(dirNames(idx).name);
        XValidation = cat(4, XValidation, x);
        YValidation = cat(1, YValidation, y);
    end
end