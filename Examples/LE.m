function y = LE(X, sigma, d)
    dis = squareform(pdist(X));
    dis = dis / max(dis(:));
    W = exp(-dis .^ 2 / sigma ^ 2);
    W = W / max(W(:));
    D = diag(sum(W, 2));
    L = D - W;
    [V, K, ~] = svds(L, d + 1, "smallest");
    disp(diag(K));
    y = V(:, 1:d);
end
