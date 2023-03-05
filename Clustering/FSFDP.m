function [label, centers, rho, delta] = FSFDP(X, sigma, clusters)
% FSFDP: Fast Search and Find of Density Peaks
%   [label, centers, rho, delta] = FSFDP(X, sigma, clusters)
%   Input:
%       X: data matrix, each row is a sample
%       sigma: parameter for Gaussian kernel
%       clusters: number of clusters
%   Output:
%       label: cluster label for each sample
%       centers: index of cluster centers
%       rho: density of each sample
%       delta: distance to the nearest cluster center

    num = size(X, 1);
    D = squareform(pdist(X));
    W = exp(-(D / sigma).^2);
    rho = sum(W, 2);
    [~, idx] = sort(rho, 'descend');

    delta = zeros([num, 1]);
    for i = 1:num
        mask = rho > rho(i);
        if sum(mask) == 0
            delta(i) = max(D(:, i));
        else
            delta(i) = min(D(mask, i));
        end
    end

    [~, centers] = sort(rho .* delta, 'descend');
    centers = centers(1:clusters);

    label = zeros([num, 1]);
    for i = 1:length(centers)
        label(centers(i)) = i;
    end
    for i = 2:num
        if label(idx(i)) ~= 0
            continue;
        else
            [~, nearst_idx] = min(D(idx(1:i-1), idx(i)));
            label(idx(i)) = label(idx(nearst_idx));
        end
    end
end