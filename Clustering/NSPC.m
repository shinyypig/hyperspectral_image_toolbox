function idx = NSPC(X, k, sigma)

%   Normalized Spectral Clustering
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

    [num, ~] = size(X);
    nbs = round(num / 5);
    if nbs > 500
        nbs = 500;
    end
    [Idx, Dist] = knnsearch(X, X, 'K', nbs);
    
    i = (1:num)' * ones([1, nbs]);
    i = i(:);
    j = Idx(:);
    v = exp(- (Dist(:)/sigma).^2);
    W = sparse(i, j, v) + sparse(j, i, v);
    
    D = diag(sum(W));
    L = D - W;
    I = sparse(1:num, 1:num, ones([num, 1]));
    
    [S, ~, ~] = svds(I - diag(D)'.^(-1/2) .* L .* diag(D).^(-1/2), k-1);
    idx = kmeans(S, k);

end
