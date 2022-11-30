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
        cart = strsplit("" + light, " ");
        x = str2double(cart(1));
        y = str2double(cart(2));
        z = str2double(cart(3));
        [th, phi] = cart2sph(x, y, z);
        YTrain = cat(1, YTrain, [th, phi]);
    end
end