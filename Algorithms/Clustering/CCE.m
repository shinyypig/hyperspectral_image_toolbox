function varargout = CCE(X, sigma, k, kmax)
%The connection center evolution (CCE) method.
%   X is the data, should be a num * d matrix.
%   sigma is the Guassian kernel parameter.
%   k is the iteration number.
%   kmax (optional) is the max iteration number.
%
%   Usage:
%   label = cee(X, sigma, k);
%   *label* is a num * 1 vector.
%
%   [label, centers] = cee(X, sigma, k);
%   The indices of the cluster centers are in *centers*.
%   
%
%   [label, centers, cnum] = cee(X, sigma, k);
%   *cnum* includes two vectors and can help plot the curve of k versus
%   number of cluster centers.

    if nargin == 3
        % The default max iteration number.
        kmax = k;
    end
    
    % The iteration gap, you can set it to a bigger integer to speed up the
    % calculation.
    d = 10;
    
    % Calculate the similarity matrix.
    [num, ~] = size(X);
    D = squareform(pdist(X));
    W = exp(-(D / sigma).^2);
    T = 1 ./ sqrt(sum(W));
    W = T' .* W .* T;
    
    % Traverse k, if the curve of k versus number of cluster centers is
    % needed.
    if nargout == 3
        Wk = W;
        Ws = W^d;
        
        klist = 1:d:kmax;
        cnum = zeros([length(klist), 1]);
        cnum(1) = num;

        for i = 2:length(klist)
            Wk = Wk * Ws;
            [~, idx] = max(Wk, [], 1);
            centers = find((1:num) == idx)';
            cnum(i) = length(centers);
        end
    end
    
    Wk = W^k;
    [~, idx] = max(Wk, [], 1);
    % Find the cluster centers.
    centers = find((1:num) == idx)';
    % Classify the remain data points.
    [~, label] = max(Wk(centers, :) ./ Wk(centers + (centers-1)*num), [], 1);
    label = label';
    
    if nargout == 1
        varargout{1} = label;
    elseif nargout == 2
        varargout{1} = label;
        varargout{2} = centers;
    elseif nargout == 3
        varargout{1} = label;
        varargout{2} = centers;
        varargout{3} = [klist', cnum];
    end
end
