function [label, centers] = MeanShift(X, r0, sigma, delta)
% MeanShift: the implementation of the MeanShift algorithm
%   Input:
%   X: n x d matrix, n is the number of data points, d is the dimension of data points
%   r0: the radius of the kernel
%   sigma: the parameter of the kernel
%   delta: the threshold of the distance between two centers
%   Output:
%   label: the label of each data point
%   centers: the centers of the clusters

    num = size (X, 1);
    flag = zeros([num, 1]);
    snum = 1:num;
    centers = [];
    V = [];
    tol = 1e-5;
    
    while true
        if sum(flag) == num
            break;
        end

        times = zeros([num, 1]);
        idx = randi(sum(~flag));
        snum_ = snum(flag < 1);
        idx = snum_(idx);
        center = X(idx, :);
        while true
            dist = sqrt(mean((X - center).^2, 2));
            times = times + (dist < r0);
            inners = find(dist < r0);
            weight = exp(- dist(inners).^2 / sigma^2);
            shift = weight' * X(inners, :) / sum(weight) - center; 
            if norm(shift) < tol
                break;
            end
            center = center + shift;
        end

        flag = bitor(flag, times > 0);

        if isempty(centers)
            centers = cat(1, centers, center);
            V = cat(2, V, times);
        else
            dist = sqrt(mean((centers - center).^2, 2));
            [m, idx] = min(dist);
            if m < delta
                V(:, idx) = V(:, idx) + times;
            else
                centers = cat(1, centers, center);
                V = cat(2, V, times);
            end
        end
    end

    [~, label] = max(V, [], 2);
end