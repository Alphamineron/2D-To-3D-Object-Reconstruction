function adjustedNormal = kMeansCluster(normal, k)
    [H, W, ~] = size(normal);
    [x, y] = meshgrid(1:H, 1:W);
    x = reshape(x, [], 1);
    y = reshape(y, [], 1);
    r = reshape(normal(:, :, 1), [], 1);
    r = 1000 * r;
    g = reshape(normal(:, :, 2), [], 1);
    g = 1000 * g;
    b = reshape(normal(:, :, 3), [], 1);
    b = 1000 * b;
    data = cat(2, x, y, r, g, b);
    idx = kmeans(data, k);
    idx = reshape(idx, H, W);
    adjustedR = zeros(H, W);
    adjustedG = zeros(H, W);
    adjustedB = zeros(H, W);
    for i = 1:k
        r = normal(:, :, 1);
        meanR = mean(r(idx == i));
        g = normal(:, :, 2);
        meanG = mean(g(idx == i));
        b = normal(:, :, 3);
        meanB = mean(b(idx == i));
        dir = [meanR, meanG, meanB];
        dir = dir/norm(dir);
        adjustedR(idx == i) = dir(1);
        adjustedG(idx == i) = dir(2);
        adjustedB(idx == i) = dir(3);
    end
    adjustedNormal = cat(3, adjustedR, adjustedG, adjustedB);
end