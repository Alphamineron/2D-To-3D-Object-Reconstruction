function [XTrain, YTrain] = loadData(dirName)
    path = "DiLiGenT/pmsData/" + dirName + "/";
    namesFile = fileread(path + "filenames.txt");
    fileNames = strsplit(namesFile, "\n");
    fileNames(end) = [];
    XTrain = [];
    for name = fileNames
        img = imread(path + name);
        XTrain = cat(4, XTrain, img);
    end
    lightFile = fileread(path + "light_directions.txt");
    lightDirs = strsplit(lightFile, "\n");
    lightDirs(end) = [];
    YTrain = [];
    for light = lightDirs
        vec = strsplit("" + light, " ");
        YTrain = cat(1, YTrain, vec);
    end
    YTrain = str2double(YTrain);
end