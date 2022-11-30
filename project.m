%[xTrain, yTrain, xValidation, yValidation] = createTrainValidation();
%net = trainLightDir(xTrain, yTrain, xValidation, yValidation);
load("light_cnn_inceptionv3");
[imgs, sphs] = loadData("bearPNG");
sphs = predict(net, imgs);
lightDirs = getLightDir(sphs);
%imgs = imgs(:, :, :, [1, 15, 30, 45, 60, 75, 90]);
%lightDirs = lightDirs([1, 15, 30, 45, 60, 75, 90], :);
img = getNormals(imgs, lightDirs);