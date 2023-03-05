function him_ = MNF(him)
    [m, n, l] = size(him);
    X = reshape(him, [], l);
    [Rn, Rs] = noise_signal_estim(him);
    Rn_ = sqrtm(pinv(Rn));
    [V, ~, ~] = svd(Rn_' * Rs * Rn_);
    V = Rn_ * V;
    Y = X * V;

    him_ = reshape(Y, [m, n, l]);
end