function y = MTCEM(X, D)
% MTCEM is a multiple targets version of CEM.
%   Assume n is the number of the pixels,
%   m is the number of the targets,
%   d is the number of the bands.
%
%   Then, 
%   X should be a n*d matrix,
%   D should be a m*d matrix.
%   It should be noted that when m=1,
%   MTCEM equals to CEM.

    [m, ~] = size(D);
    R = X' * X;
    R_ = pinv(R);
    w = R_ * D' * pinv(D * R_ * D') * ones(m, 1); 
    y = X * w;
end