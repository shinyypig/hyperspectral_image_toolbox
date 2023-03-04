function [Rn, Rs] = noise_signal_estim(him)
    [m, n, l] = size(him);
    X = reshape(him, [], l);
    S = zeros([m, n, l]);
    
    for i = 1:l
        S(:, :, i) = conv2(squeeze(him(:, :, i)), ones(3) / 9, 'same');
    end
    
    S = reshape(S, [], l);
    Rs = S' * S;
    Rn = (X - S)' * (X - S);
end