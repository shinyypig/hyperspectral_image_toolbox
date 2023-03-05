function S = FastICA(X, c)
%FastICA Fast Independent Component Analysis
%   X is a N * l matrix
%   c is the number of the components
%   Y is a N * c matrix

    [n, l] = size(X);
    X = X - mean(X, 1);
    R = X' * X / n;
    X = X * sqrtm(pinv(R));

    tol = 1e-5;
    
    W = randn([l, c]);
    W = W ./ sqrt(sum(W.^2, 1));

    for i = 1: 500
        Wp = W;
        W = X' * G(X*W) - W .* mean(Gp(X*W), 1);
        W = W ./ sqrt(sum(W.^2, 1));
        [U, S, ~] = svd(W,'econ');
        W = U * diag(1 ./ diag(S)) * U' * W;
        delta = norm(W - Wp);
        if delta < tol
            break;
        end
    end
    
    S = X * W;
end

function y = G(x)
    y = 4 * x.^3;
end

function y = Gp(x)
    y = 12 * x.^2;
end

% function y = G(x)
%     y = tanh(x);
% end
% 
% function y = Gp(x)
%     y = 1- tanh(x).^2;
% end