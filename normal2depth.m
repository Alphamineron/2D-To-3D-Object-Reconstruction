function depth = normal2depth(normal)
    [H, W, ~] = size(normal);
    dx = normal(:, :, 1) ./ normal(:, :, 3);
    dy = normal(:, :, 2) ./ normal(:, :, 3);
    depth1 = zeros(H, W);
    depth1(1, 1) = 0;
    for y = 2:H
        if y ~= 1
            depth1(y, 1) =  depth1(y-1, 1) - dy(y, 1);
        end
        for x = 2:W
            depth1(y, x) =  depth1(y, x-1) - dx(y, x);
        end
    end
    for y = 1:H
        mean1 = mean(depth1(y, :));
        for x = 1:W
            depth1(y, x) =  depth1(y, x) - mean1;
        end
    end
    depth2 = zeros(H, W);
    depth2(1, 1) = 0;
    for x = 2:W
        if x ~= 1
            depth2(1, x) = depth2(1, x-1) + dx(1, x);
        end
        for y = 2:H
            depth2(y, x) = depth2(y-1, x) + dy(y, x);
        end
    end
    for x = 1:W
        mean2 = mean(depth2(:, x));
        for y = 1:H
            depth2(y, x) = depth2(y, x) - mean2;
        end
    end
    depth = depth1 + depth2;
    depth = depth - min(depth(:));
    depth = depth / max(depth(:));
end