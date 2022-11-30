function lightDir = getLightDir(sphs)
    [H, ~] = size(sphs);
    lightDir = [];
    for i = 1:H
        th = sphs(i, 1);
        phi = sphs(i, 2);
        [x, y, z] = sph2cart(th, phi, 1);
        lightDir = cat(1, lightDir, [x, y, z]);
    end
end