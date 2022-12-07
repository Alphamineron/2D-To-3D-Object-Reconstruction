%[xTrain, yTrain, xValidation, yValidation] = createTrainValidation();
%net = trainLightDir(xTrain, yTrain, xValidation, yValidation);
%load("light_cnn_inceptionv3");
name = "bearPNG";
[imgs, sphs] = loadData(name);
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
%sphs = predict(net, imgs);
lightDirs = getLightDir(sphs);
%imgs = imgs(:, :, :, [1, 15, 30, 45, 60, 75, 90]);
%lightDirs = lightDirs([1, 15, 30, 45, 60, 75, 90], :);
normal = getNormals(imgs, lightDirs);
depth = normal2depth(normal);
[H, W] = size(depth);
[X, Y] = meshgrid(1:W, 1:H);
mesh(X, Y, depth);
colormap([1, 1, 1]);
camlight;