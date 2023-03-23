%% load data
clear; close all;
him = double(importdata('Indian_pines.mat'));
[m, n, l] = size(him);
X = reshape(him, m * n, l);

%% plot the spectrum of randomly selected pixels
idx = randperm(m * n, 50);
% X_ = X - mean(X, 1);
R = X' * X;
X_ = X / sqrtm(R);

figure;
subplot(2, 1, 1), plot(X(idx, :)');
xlabel('Band');
xlim([0, l - 1]);
title('Original');

subplot(2, 1, 2), plot(X_(idx, :)');
title('Whitened');
xlim([0, l - 1]);
xlabel('Band');
exportgraphics(gcf, '../img/sam_spectral.png');

%% plot the correlation of the spectrum of
% the randomly selected pixels between that of the first pixel

d = X(idx(1), :);
X_norm = sqrt(sum(X .^ 2, 2));
d_norm = norm(d);

R = X(idx, :) * d' ./ (X_norm(idx) * d_norm);
% R = R / max(R(:));

d_ = X_(idx(1), :);
X_norm_ = sqrt(sum(X_ .^ 2, 2));
d_norm_ = norm(d_);

R_ = X_(idx, :) * d_' ./ (X_norm_(idx) * d_norm_);
% R_ = R_ / max(R_(:));

figure;
subplot(2, 1, 1), plot(R);
xlabel('Pixel index');
title('Original');

subplot(2, 1, 2), plot(R_);
xlabel('Pixel index');
title('Whitened');
exportgraphics(gcf, '../img/sam_pixel.png');
