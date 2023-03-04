function Y = PCA(X, c)
%PCA Principal Component Analysis
%   X is a N * l matrix
%   c is the number of the components
%   Y is a N * c matrix

    R = X' * X;
    [U, ~, ~] = svd(R);
    Y = X * U(:, 1:c);
end

