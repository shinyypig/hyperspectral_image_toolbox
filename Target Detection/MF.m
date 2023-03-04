function y = MF(X, d)

%MF is a classic target detection algorithm.
%   Assume n is the number of the pixels,
%   d is the number of the bands.
%
%   Then, 
%   X should be a n*d matrix,
%   D should be a 1*d matrix.

    m = mean(X, 1);
    X = X - m;
    d = d - m;
    
    R = X' * X;
    R_ = pinv(R);
    w = R_ * d' / (d * R_ * d');
    y = X * w;
end