function offset = IDFT_US(im1, im2, k)
%the IDFT_US algorithm
%   k is the upsampling factor

    [m, n] = size(im1);
    I1 = fft2(im1);
    I2 = fft2(im2);
    
    R = I1 .* conj(I2);
    
    r = abs(ifft2(fftshift(R)));

    [l, m0] = max(r);
    [~, n0] = max(l);
    m0 = m0(n0);
    m0 = (m0 - 1);
    n0 = (n0 - 1);

    M = fftshift(R);
    u = 1: m;
    v = 1: n;
    [u, v] = meshgrid(u, v);
    u = double(u');
    v = double(v');
    L = exp(1j * 2 * pi *(u*m0/m + v*n0/n));
    P = M .* L;

    u = 1: m;
    v = 1: n;
    [U, V] = meshgrid(u, (-k: k) / k);
    U = U .* V;
    U_ = U;
    [U, V] = meshgrid(v, (-k: k) / k);
    V = U .* V;
    V_ = V';
    r_ = abs(exp(1j * 2 * pi * U_ / m) * P * exp(1j * 2* pi * V_ / n));

    [l, x_] = max(r_);
    [~, y_] = max(l);
    x_ = x_(y_);
    m0 = m0 + (x_ - 1 - k) / k;
    n0 = n0 + (y_ - 1 - k) / k;
    offset = [m0, n0];
end