[xTrain, yTrain, xValidation, yValidation] = createTrainValidation();
net = trainLightDir(xTrain, yTrain, xValidation, yValidation);

[imgs, ~] = loadData("bearPNG");
lightDirs = normr(predict(net, imgs));
imgs = imgs(:, :, :, [1, 15, 30, 45, 60, 75, 90]);
lightDirs = lightDirs([1, 15, 30, 45, 60, 75, 90], :);
img = getNormals(imgs, lightDirs);