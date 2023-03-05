function [m0, n0] = HOGE(im1, im2)
%the CSM algorithm
    [m, n] = size(im1);

    I1 = fftshift(fft2((im2)));
    I2 = fftshift(fft2((im1)));
   
    I = I1 ./ I2;
    I = medfilt2(angle(I));
    
    [cx, cy] = meshgrid(1:n, 1:m);
    cx = cx - m / 2 - 0.5;
    cy = cy - n / 2 - 0.5;
    mask = sqrt(cx.^2 + cy.^2) < min([m, n]) / 4;
    I = I(mask);
    cx = cx(mask);
    cy = cy(mask);
    slop = regress(I, [cx, cy]);
    
    m0 = slop(2) * m / 2 / pi;
    n0 = slop(1) * n / 2 / pi;
end
