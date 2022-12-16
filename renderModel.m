function renderModel(dirName, k)
    load("light_cnn_inceptionv3");
    [imgs, ~] = loadData(dirName);
    sphs = predict(net, imgs);
    lightDirs = getLightDir(sphs);
    normal = getNormals(imgs, lightDirs);
    if k ~= 0
        normal = kMeansCluster(normal, k);
    end
    depth = frankotChellappa(normal(:, :, 1) ./ normal(:, :, 3), normal(:, :, 2) ./ normal(:, :, 3));
    mask = imread(dirName + "/mask.png");
    depth(mask == 0) = nan;
    figure;
    mesh(depth);
    colormap([1, 1, 1]);
    camlight;
end