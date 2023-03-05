function [A, S] = MVCNMF(X, k)
% MVCNMF: Minimum Volume Constrained Nonnegative Matrix Factorization
%   [A, S] = MVCNMF(X, k) returns the factor matrices A and S such that
%   X = AS. The number of columns of A is k. The number of rows of S is k.
%   S is the source matrix, and A is the fractional abundance matrix.
    c = 1;
    tol = 1e-6;
    a = 1e-2;
    b = 1e-2;
    V = X;
    [num, d] = size(X);
    X = ones(num, d+1) * c;
    X(:, 1:end-1) = V;
    S = X(1:k, :);
    A = NNLS(S', X')';
    
    for i = 1:5000
        S_ = S;
        S_(:, end) = 0;
        dA = (A * S - X) * S';
        dS = A' * (A * S - X) + b * det(S_*S_') * pinv(S_*S_') * S_;

        A = A - a * dA;
        S = S - a * dS;
        A(A < 0) = 0;
        S(S < 0) = 0;

        S(:, end) = c;
        
        if max(abs(dA)) < tol
            break;
        end
    end
    S = S(:, 1:end-1);
end