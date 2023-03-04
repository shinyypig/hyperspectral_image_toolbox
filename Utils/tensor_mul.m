function M = tensor_mul(T, X, d)
%TENSOR_MUL is the tensor multiply function
%   T is a tensor
%   X is a matrix
%   d is the multiplication dimension
    Tshape = size(T);
    Xshape = size(X);

    Mshape = Tshape([d, 1:d - 1, d + 1:length(Tshape)]);
    Mshape(1) = Xshape(2);

    T = permute(T, [d, 1:d - 1, d + 1:length(Tshape)]);
    T = reshape(T, Xshape(1), []);

    M = X' * T;
    M = reshape(M, Mshape);
    M = permute(M, [2:d, 1, d + 1:length(Tshape)]);
end
