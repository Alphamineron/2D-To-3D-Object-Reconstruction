%[xTrain, yTrain, xValidation, yValidation] = createTrainValidation();
%net = trainLightDir(xTrain, yTrain, xValidation, yValidation);
%load("light_cnn_inceptionv3");
%noLight = imresize(imread("kevin/android/noLight.png"), [512, 612]);
%vidObj = VideoReader('kevin/android/android.mp4');
%imgs = [];
%i = 31;
%while hasFrame(vidObj)
%    vidFrame = imresize(readFrame(vidObj), [512, 612]) - noLight;
%    if i > 15
%        imgs = cat(4, imgs, vidFrame);
%        i = 0;
%    end
%    i = i + 1;
%end
depths = [];
dirName = "bearPNG";
names = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"];
names = ["01"];
for i = 1:names.length
    name = "view_" + names(i);
    [imgs, sphs] = loadData(name, "DiLiGenT-MV/" + dirName);
    %sphs = predict(net, imgs);
    lightDirs = getLightDir(sphs);
    %imgs = imgs(:, :, :, [1, 15, 30, 45, 60, 75, 90]);
    %lightDirs = lightDirs([1, 15, 30, 45, 60, 75, 90], :);
    normal = getNormals(imgs, lightDirs);
    %normal = kMeansCluster(normal, 7);
    depth = frankotChellappa(normal(:, :, 1) ./ normal(:, :, 3), normal(:, :, 2) ./ normal(:, :, 3));
    %depth = normal2depth(normal);
    mask = imread("DiLiGenT-MV/" + dirName + "/" + name + "/mask.png");
    depth(mask == 0) = nan;
    depths = cat(3, depths, depth);
end
surf2stl('test.stl', 1, 1, depths(:, :, 1));
i = 1;
model = mesh(depths(:, :, 1));
colormap([1, 1, 1]);
camlight;
% while true
%     model.ZData = depths(:, :, i+1);
%     i = mod(i + 1, size(depths, 3));
%     pause(0.05);
% end