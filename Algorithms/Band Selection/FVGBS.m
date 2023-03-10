function sel_list = FVGBS(him, num)
%FVGBS is the faster version of VGBS.
%   him -- the hyperspectral image, should be the size of m*n*d.
%   num -- the number of the bands shoule be selected.

    [m, n, l] = size(him);

    X = reshape(him, [], l);
    R = X' * X / m / n;
    K = pinv(R);

    sel_list = 1:l;

    for i = num + 1: l
        [~, idx] = max(diag(K));

        c = K(idx, idx);
        K(:, idx) = [];
        b = -K(idx, :);
        K(idx, :) = [];

        K = K - b' * b / c;

        sel_list(idx) = [];
    end
end
