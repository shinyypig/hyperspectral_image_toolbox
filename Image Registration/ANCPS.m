function offset = ANCPS(im1, im2, num)
%the iterative verison of ANCPS
%   num is the number of iterations
%   offset is a num*2 matrix, which contains the result of each iteration

    % calculate the integer part of the displacments
    loc = IDFT_US(im1, im2, 2);
    mi = round(loc(1));
    ni = round(loc(2));
    
    % crop the two images
    if mi > 0
        im1 = im1(mi+1:end, :);
        im2 = im2(1:end-mi, :);
    elseif mi < 0
        im1 = im1(1:end+mi, :);
        im2 = im2(1-mi:end, :);
    end
    
    if ni > 0
        im1 = im1(:, ni+1:end);
        im2 = im2(:, 1:end-ni);
    elseif mi < 0
        im1 = im1(:, 1:end+ni);
        im2 = im2(:, 1-ni:end);
    end
    
    % initial for iteration
    offset = zeros(num, 2);
    [m, n] = size(im1);
    I2 = fftshift(fft2(im2));
    px = ((1:m) - (m+1)/2)' * ones([1, n]) / m;
    py = ones([m, 1]) * ((1:n) - (n+1)/2) / n;

    mf = 0;
    nf = 0;
    % remove the outermost pixels of the reference image
    im1_ = im1(2:end-1, 2:end-1);
    
    for i = 1:num
        % remove the outermost pixels of the image to be matched
        im2_ = im2(2:end-1, 2:end-1);
        
        % calculate the decimal part of the displacments
        [m_, n_] = ANCPS_Reg(im1_, im2_);
        
        % add the new estimated displacements to the cummulative
        % displacements
        mf = m_ + mf;
        nf = n_ + nf;
        
        % cyclically shift the second image
        im2 = ifft2(ifftshift(I2 .* exp(-2j*pi*(mf*px + nf*py))));
        
        % record the estimation of each iteration
        offset(i, 1) = mi + mf;
        offset(i, 2) = ni + nf;
    end
end

function [m0, n0] = ANCPS_Reg(im1, im2)
%the ANCPS algorithm
%   m0, n0 are the decimal matching result

    [m, n] = size(im1);

    I1 = fftshift(fft2((im2)));
    I2 = fftshift(fft2((im1)));
    
    % remove the part that does not participate in the calculation 
    gap = round(min([m, n]) / 4);
    I1 = I1(round(m/2)-gap:round(m/2)+gap, round(n/2)-gap:round(n/2)+gap);
    I2 = I2(round(m/2)-gap:round(m/2)+gap, round(n/2)-gap:round(n/2)+gap);
    
    % calculate NCPS
    I = I1 ./ I2;
    I = I ./ abs(I);
    
    % only keep the components within the circle
    [m_, n_] = size(I);
    [cx, cy] = meshgrid(1:n_, 1:m_);
    mask = sqrt((cx - m_/2 - 0.5).^2 + (cy - n_/2 - 0.5).^2) < min([m_, n_]) / 2;
    I = I .* mask;
    
    % calculate ANCPS
    M = conv2(I, I, "same");
    M = M ./ abs(M);
    
    % generate the vectors that are used to estimate the displacements
    [m_, n_] = size(M);
    [cx, cy] = meshgrid(1:n_, 1:m_);
    mask = sqrt((cx - m_/2 - 0.5).^2 + (cy - n_/2 - 0.5).^2) < min([m_, n_]) / 2 - 1;
    maskx = zeros(m_, n_) > 0;
    maskx(2:end, :) = mask(1:end-1, :);
    masky = zeros(m_, n_) > 0;
    masky(:, 2:end) = mask(:, 1:end-1);
    q = M(mask);
    px = M(maskx);
    py = M(masky);
    
    % estimate the displacements
    m0 = angle(TLS(q(:), px(:))) * m / 2 / pi;
    n0 = angle(TLS(q(:), py(:))) * n / 2 / pi;
end
