function idx = SC(X, k, sigma)

%   Spectral Clustering
%   X is data, n*d matrix
%   n is number of samples
%   d is number of original dimension
%   
%   Then,
%   k is the number of clusters
%
%   So,
%   the output idx is the label of each samlpe
%   idx is a n*1 matrix

    W = exp(-squareform((pdist(X) / sigma).^2));
    D = diag(sum(W));
    L = D - W;
    [S, ~, ~] = svd( - diag(D)'.^(-1/2) .* L .* diag(D).^(-1/2));
    idx = kmeans(S(:, end-k:end-1), k);

end
