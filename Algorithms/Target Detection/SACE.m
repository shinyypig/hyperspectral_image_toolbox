function y = SACE(X, D)
% Simplex ACE
%   input:
%   X: the n*d data matrix, where n is the number of pixels and d is the
%   number of bands
%   D: the c*d target matrix, where c is the number of targets
%   ouput:
%   y: the n*1 detection output vector
    R = X' * X;
    R_ = pinv(sqrtm(R));
    [num, ~] = size(X);
    [len, ~] = size(D);
    
    X = X * R_;
    D = D * R_;
    
    A = zeros([num, len]);
    parfor i = 1: num
        A(i, :) = lsqnonneg(D', X(i, :)');
    end
    
    y = sqrt(mean((A * D).^2, 2) ./ mean(X.^2, 2));
end