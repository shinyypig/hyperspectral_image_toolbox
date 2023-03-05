function W = NNLS(X, Y)
%NNLS Non-negative Least Squares
%   Assume that there N data points
%   X is an N*n matrix
%   Y is an N*m matrix
%   W is an n*m matrix
%   Y = XW
    [N, n] = size(X);
    [~, m] = size(Y);
    
    A = zeros([N, n]*m);
    for i = 1:m
        A((i-1)*N+1:i*N, (i-1)*n+1:i*n) = X;
    end
    b = reshape(Y, [], 1);
    H = A' * A;
    f = -b'*A;
    options = optimoptions('quadprog', "Display", "off");
    w = quadprog(H, f, [], [], [], [], zeros([n*m, 1]), [], [], options);
    W = reshape(w, [n, m]);
end