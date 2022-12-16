function normals = getNormals(imgs, lightDirs)
    grayImgs = squeeze(mean(imgs, 3));
    
    S = inv(lightDirs.' * lightDirs) * lightDirs.';
    
    [H, W, C] = size(grayImgs);

    normals = zeros(H, W, 3);
    for x = 1:W
        for y=1:H
            I = squeeze(grayImgs(y, x, :));
            normal = S * I;
            normal = normal / norm(normal);
            normals(y, x, 1) = normal(1);
            normals(y, x, 2) = normal(2);
            normals(y, x, 3) = normal(3);
        end
    end
end