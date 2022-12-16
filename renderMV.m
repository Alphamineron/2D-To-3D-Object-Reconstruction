function renderMV(path)
    load("light_cnn_inceptionv3");
    depths = [];
    dirNames = dir(path);
    dirNames(1) = [];
    dirNames(1) = [];
    totalDirs = length(dirNames);
    for i = 1:totalDirs
        name = dirNames(i).name
        [imgs, ~] = loadData(path + "/" + name);
        sphs = predict(net, imgs);
        lightDirs = getLightDir(sphs);
        normal = getNormals(imgs, lightDirs);
        depth = frankotChellappa(normal(:, :, 1) ./ normal(:, :, 3), normal(:, :, 2) ./ normal(:, :, 3));
        mask = imread(path + "/" + name + "/mask.png");
        depth(mask == 0) = nan;
        depths = cat(3, depths, depth);
    end
    i = 1;
    model = mesh(depths(:, :, 1));
    rotate(model, [0 0 1], 90);
    rotate(model, [0 1 0], -45);
    rotate(model, [0 0 1], 45);
    colormap([1, 1, 1]);
    camlight;
    while true
        model.ZData = depths(:, :, i+1);
        i = mod(i + 1, size(depths, 3));
        pause(0.05);
    end
end