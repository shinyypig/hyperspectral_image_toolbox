function [U, V] = NMF(X, k)
% NMF Non-negative matrix factorization
%   [U, V] = NMF(X, k) returns two non-negative matrices U and V such that
%   X = U * V. The number of columns of U is k, and the number of rows of V
    [m, n] = size(X);
    
    U = rand(m, k);
    V = rand(k, n);
    
    U_ = U;
    V_ = V;
    
    for t = 1:20
        for i = 1:2000

            U = U .* (X * V') ./ (U * (V * V'));
            V = V .* (U' * X) ./ ((U' * U) * V);
            if mean((X - U*V).^2, 'all') < 1e-10
                break;
            end
        end

        if mean([(U(:) - U_(:)).^2; (V(:) - V_(:)).^2]) < 1e-5
            break;
        end

        U_ = U;
        V_ = V;

        U = U + 1e-5 * rand(m, k);
        V = V + 1e-5 * rand(k, n);
    end
end
