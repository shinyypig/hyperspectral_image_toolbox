function y = MTICEM(X, D)
% multiple targets inequality constrained energy minimization
%   input:
%   X: the n*d data matrix, where n is the number of pixels and d is the
%   number of bands
%   D: the c*d target matrix, where c is the number of targets
%   ouput:
%   y: the n*1 detection output vector
    
    [c, ~] = size(D);
    
    R = X' * X;
    
    options = optimoptions('quadprog', 'Display', 'off', 'ConstraintTolerance', 1e-3, 'OptimalityTolerance', 1e-5);
    w = quadprog(R, [], -D, -ones(c, 1), [], [], [], [], [], options);
    
    y = X * w;
end