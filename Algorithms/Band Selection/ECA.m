function Band = ECA(him, n)
    %% ======About ECA====== %%
    % Kang Sun, Xiurui Geng, Luyan Ji. "Exemplar component analysis: a fast
    % band selection method for hyperspectral imagery", IEEE Geoscience and
    % Remote Sensing Letters. 2015, 12(5):998-1002.

    % Author: Kang Sun, Dec. 2014
    % For public release
    % All rights reserved
    %% ======Input variables====== %%
    % x, The 2-D hyperspectral image with size L*N, where
    %     L is the number of total bands, N is the number of pixels
    % n,  the number of selected bands.

    %% ======Output variables====== %%
    % Band, the selected band numbers

    %% =============ECA============ %%
    L = size(him, 3);
    X = reshape(him, [], L);
    %% =======Compute distance Matrix====== %%
    R = X' * X;
    Temp = diag(R) * ones(1, L);
    D = sqrt(Temp + Temp' - 2 * abs(R)); %Distance matrix

    %% ======Compute rho======%%
    sigma = mean(mean(D)) / 0.1; %parameter sigma,can be modified for different datasets
    % sigma=mean(mean(D))/30;
    W = exp(- (D ./ sigma));
    rho = sum(W, 2); %rho, measuring the local density

    %% ======Compute delta====== %%
    delta = zeros(L, 1);
    [~, Ind1] = max(rho);
    for i = 1:L
        if (i ~= Ind1)
            Ind = rho > rho(i);
            TempD = D(Ind, i);
            delta(i) = min(TempD);
        end
    end
    delta(Ind1) = mean(delta);

    %% ======Cumpute ES====== %%
    ES = rho .* delta; %Exemplar socre defined in the paper
    [~, Ind] = sort(ES, 'descend');
    Band = Ind(1:n);
    Band = sort(Band);
end
