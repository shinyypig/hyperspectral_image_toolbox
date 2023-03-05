function [im1, im2] = img_pair_gen(im, step, integer, decimal)
% generate image pairs with decimal displacements
    base = 200;
    im = im(1+base:1400+base, 1+base:1400+base);
    
    im1 = im(1: step : end - step * integer, 1: step : end - step * integer);
    im2 = im(1 + decimal(1) + step * integer: step : end, 1 + decimal(2) + step * integer: step : end);
    im1 = mat2gray(im1);
    im2 = mat2gray(im2);
end