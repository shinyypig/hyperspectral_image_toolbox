function y = LLE(X, k, d) 
%LLE is a Manifold Learning function
%   X is data, N*D matrix
%   N is number of samples
%   D is number of original dimension
%   
%   Then,
%   k is the number of neighbor
%   d is the number of output dimension

%   So,
%   the output data y is a N*d matrix
    [N, ~] = size(X);
    
    %   find knn
    idx = zeros([N, k]);
    for i = 1: N
        idx_ = knnsearch(X, X(i, :), 'K', k+1);
        idx(i, :) = idx_(2:end);
    end
    
    %   M = (I - W) * (I - W)' = I - W - W' + W * W'
    M = eye(N);
    tol=1e-4;
    for i = 1 : N
        Z = X(i, :) - X(idx(i, :), :);
        w = pinv(Z * Z' + eye(k) * tol * trace(Z * Z')) * ones(k, 1);
        w = w / sum(w);
        
        M(i, idx(i, :)) = M(i, idx(i, :)) - w';
        M(idx(i, :), i) = M(idx(i, :), i) - w;
        M(idx(i, :), idx(i, :)) = M(idx(i, :), idx(i, :)) + w * w';
    end

    [U, ~, ~] = svds(M, d+1, 'smallest');
    y = U(:, 1:end-1);
end

