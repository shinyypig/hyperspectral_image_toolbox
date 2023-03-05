function offset = CSM(im1, im2, num)
% the iterative version of CSM
    loc = IDFT_US(im1, im2, 2);
    ui = round(loc(1));
    vi = round(loc(2));
    
    if ui > 0
        im1 = im1(ui+1:end, :);
        im2 = im2(1:end-ui, :);
    elseif ui < 0
        im1 = im1(1:end+ui, :);
        im2 = im2(1-ui:end, :);
    end
    
    if vi > 0
        im1 = im1(:, vi+1:end);
        im2 = im2(:, 1:end-vi);
    elseif ui < 0
        im1 = im1(:, 1:end+vi);
        im2 = im2(:, 1-vi:end);
    end
     
    offset = zeros(num, 2);
    [m, n] = size(im1);
    I2 = fftshift(fft2(im2));
    px = ((1:m) - (m+1)/2)' * ones([1, n]) / m;
    py = ones([m, 1]) * ((1:n) - (n+1)/2) / n;
    
    uf = 0;
    vf = 0;
    for i = 1:num
        if i > 1
            im2_ = ifft2(ifftshift(I2 .* exp(-2j*pi*(uf*px + vf*py))));
        else
            im2_ = im2;
        end
        im1_ = im1(2:end-1, 2:end-1);
        im2_ = im2_(2:end-1, 2:end-1);
        [u, v] = HOGE(im1_, im2_);
        uf = u + uf;
        vf = v + vf;

        offset(i, 1) = ui + uf;
        offset(i, 2) = vi + vf;
    end
end
