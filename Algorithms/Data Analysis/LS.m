function W = LS(X, Y)
%LS Least Squares
%   Assume that there N data points
%   X is an N*n matrix
%   Y is an N*m matrix
%   W is an n*m matrix
%   Y = XW
    W = pinv(X' * X) * (X' * Y);
end