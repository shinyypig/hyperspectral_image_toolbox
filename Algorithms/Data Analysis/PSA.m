function [X, U] = PSA(X, k)
    % Principal Skewness Analysis
    %   X: N x L data matrix
    %   k: number of principal components
    %   X: N x k principal components
    d = size(X, 2);
    % white the data
    X = X - mean(X, 1);
    X = X * (X' * X) ^ (-1/2);

    % create the statistical tensor
    S = create_tensor(X);
    % create empty matrix for principal directions
    U = zeros(d, k);
    tol = 1e-10;

    % find the principal directions
    for i = 1:k
        % random initialization
        u = randn([d, 1]);
        u = u ./ norm(u);
        u_ = u;
        % project u onto the orthogonal complement of U
        P = eye(d) - U * U';

        % find the principal direction
        for t = 1:1000
            S1 = tensor_mul(S, u, 3);
            u = tensor_mul(S1, u, 2);
            u = P * u;
            u = u ./ norm(u);
            if norm(u - u_) < tol
                break;
            end
            u_ = u;
        end
        % store the principal direction
        U(:, i) = u;
    end
    % project the data onto the principal directions
    X = X * U;
end
