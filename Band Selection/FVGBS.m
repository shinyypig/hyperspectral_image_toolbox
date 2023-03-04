function sel_list = FVGBS(him, noisyBands, num)
%FVGBS is the faster version of VGBS.
%   him -- the hyperspectral image, should be the size of m*n*d.
%
%   noisyBands -- the index of noisyBands, shoule be a list, i.e., [1 5 7]
%   if there is no noisyBand, noisyBands = [].
%   
%   num -- the number of the bands shoule be selected.

    [m, n, l] = size(him);
    
    him(:, :, noisyBands) = [];

    x = reshape(him, [], l - length(noisyBands));
    R = x' * x / m / n;
    K = pinv(R);

    sel_list = (1: l)';
    sel_list(noisyBands) = [];

    for i = num + 1: l - length(noisyBands)
        [~, idx] = max(diag(K));

        c = K(idx, idx);
        K(:, idx) = [];
        b = -K(idx, :);
        K(idx, :) = [];

        K = K - b' * b / c;

        sel_list(idx) = [];
    end
end
