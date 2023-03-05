function L = SNMF(R, k)
% Symmetric Nonngeative Matrix Factorization
%   R: d x d matrix
%   k: number of latent factors
%   L: d x k matrix
    d = size(R, 1);
    rho = 1;
    tol = 1e-6;

    A = abs(randn([d, k]));
    B = abs(randn([d, k]));
    Al = abs(randn([d, k]));
    Bl = abs(randn([d, k]));
    L = 0;
    
    A_ = A;
    B_ = B;
    L_ = L;
    for t = 1:5000
        A = (R * B + rho * L + Al) * pinv(B' * B + rho * eye(k));
        B = (R * A + rho * L + Bl) * pinv(A' * A + rho * eye(k));
        L = (A - Al/rho + B - Bl/rho) / 2;
        L(L < 0) = 0;
        Al = Al + rho * (L - A);
        Bl = Bl + rho * (L - B);
        e = f_norm(A - A_) / f_norm(A_) +...
            f_norm(B - B_) / f_norm(B_) +...
            f_norm(L - L_) / f_norm(L_);
        if e < tol
            break;
        end
        A_ = A;
        B_ = B;
        L_ = L;
    end
end

function v = f_norm(X)
    v = sqrt(sum(X.^2, 'all'));
end