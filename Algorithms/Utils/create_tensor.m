function S = create_tensor(X)
% Create the statistical tensor of X
%   X: N x L data matrix
%   S: L x L x L statistical tensor
    [N, L] = size(X);
    S = zeros(L, L, L);
    for i = 1:L
        P = X(:, i:end)' * (X(:, i:end) .* X(:, i)) / N;
        S(i, i:end, i:end) = P;
        S(i:end, i, i:end) = P;
        S(i:end, i:end, i) = P;
    end
end