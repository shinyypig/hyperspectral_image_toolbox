function offset = SVD_RANSAC(im1, im2)
%the SVD_RANSAC algorithm
% the threshold is set to 0.2 in this code
    threshold = 0.2;
    
    I1 = fft2(im1);
    I2 = fft2(im2);
    R = fftshift(I1 .* conj(I2));
    phase = R ./ abs(R);
    [m, n] = size(im1);
    
    rx = round(m / 4);
    ry = round(n / 4);
    
    phase_cut = phase(rx: 3*rx, ry: 3*ry);
    
    [u, ~, v] = svd(phase_cut);
    
    u = unwrap(angle(u(:, 1)));
    v = unwrap(angle(v(:, 1)));

    points = [(0: length(u) - 1)', u];

    line_model = fitPolynomialRANSAC(points, 1, threshold);
    m0 = abs(line_model(1)) * m / 2 / pi;

    points = [(0: length(v) - 1)', v];
    
    line_model = fitPolynomialRANSAC(points, 1, threshold);
    n0 = abs(line_model(1)) * n / 2 / pi;
    
    offset = [m0, n0];
end