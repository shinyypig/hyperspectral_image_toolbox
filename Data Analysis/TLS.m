function W = TLS(X, Y)
%TLS Toal Least Squares
%   Assume that there N data points
%   X is an N*n matrix
%   Y is an N*m matrix
%   W is an n*m matrix
%   Y = XW
    [~, m] = size(Y);
    A = [Y, X];
    [U, ~, ~] = svd(A' * A);
    U1 = U(1:m, end-m+1:end);
    U2 = U(m+1:end, end-m+1:end);
    W = -U2 * pinv(U1);
end