function y = SAM(X, d)

%SAM is a classic target detection algorithm.
%   Assume n is the number of the pixels,
%   d is the number of the bands.
%
%   Then, 
%   X should be a n*d matrix,
%   D should be a 1*d matrix.

    cos_y = X * d' ./ sqrt(sum(X.^2, 2)) ./ norm(d);
    y = acos(cos_y);
end