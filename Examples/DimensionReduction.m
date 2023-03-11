%%
clear, close all;

%% Gaussian Distribution Data
num = 500;
D = diag([3, 2, 1]);
X = randn(num, 3) * D;
C = X(:, 1);
figure, scatter3(X(:, 1), X(:, 2), X(:, 3), [], C, 'filled');
title('Gaussian Distribution Data'), axis equal;
exportgraphics(gcf, 'Examples/results/DR_data1.png');

X_PCA = PCA(X, 2);
X_PSA = PSA(X, 2);
X_LLE = LLE(X, 10, 2);

figure('Position', [0, 0, 1000, 300]);
subplot(131);
scatter(X_PCA(:, 1), X_PCA(:, 2), [], C, 'filled');
title('PCA'), axis equal;

subplot(132);
scatter(X_PSA(:, 1), X_PSA(:, 2), [], C, 'filled');
title('PSA'), axis equal;

subplot(133);
scatter(X_LLE(:, 1), X_LLE(:, 2), [], C, 'filled');
title('LLE'), axis equal;

exportgraphics(gcf, 'Examples/results/DR_data1_result.png');
%% Gaussian Distribution Data with Outliers
num = 500;
D = diag([3, 2, 1]);
X = randn(num, 3) * D;
X = cat(1, X, randn(10, 3) + [0, 0, 10]);
C = X(:, 3);
figure, scatter3(X(:, 1), X(:, 2), X(:, 3), [], C, 'filled');
title('Gaussian Distribution Data with Outliers'), axis equal;
exportgraphics(gcf, 'Examples/results/DR_data2.png');

X_PCA = PCA(X, 2);
X_PSA = PSA(X, 2);
X_LLE = LLE(X, 10, 2);

figure('Position', [0, 0, 1000, 300]);
subplot(131);
scatter(X_PCA(:, 1), X_PCA(:, 2), [], C, 'filled');
title('PCA'), axis equal;

subplot(132);
scatter(X_PSA(:, 1), X_PSA(:, 2), [], C, 'filled');
title('PSA'), axis equal;

subplot(133);
scatter(X_LLE(:, 1), X_LLE(:, 2), [], C, 'filled');
title('LLE'), axis equal;

exportgraphics(gcf, 'Examples/results/DR_data2_result.png');
%% Swiss Roll Data
num = 500;
theta = linspace(0, 2.5*pi, 30);

[Xt, Xw] = meshgrid(theta, linspace(0, 1, 40));
Xr = Xt(:) / max(Xt(:)) / 2 + 1/2;
Xt = Xt(:) + rand(size(Xt(:))) * 0.4;
Xw = Xw(:) + rand(size(Xw(:))) * 0.1;
X = [cos(Xt) .* Xr, sin(Xt) .* Xr, Xw];
C = Xt;
figure, scatter3(X(:, 1), X(:, 2), X(:, 3), [], C, 'filled');
title('Swiss Roll Data'), axis equal;
view(280, 80);
exportgraphics(gcf, 'Examples/results/DR_data3.png');

X_PCA = PCA(X, 2);
X_PSA = PSA(X, 2);
X_LLE = LLE(X, 12, 2);

figure('Position', [0, 0, 1000, 300]);
subplot(131);
scatter(X_PCA(:, 1), X_PCA(:, 2), [], C, 'filled');
title('PCA'), axis equal;

subplot(132);
scatter(X_PSA(:, 1), X_PSA(:, 2), [], C, 'filled');
title('PSA'), axis equal;

subplot(133);
scatter(X_LLE(:, 1), X_LLE(:, 2), [], C, 'filled');
title('LLE'), axis equal;

exportgraphics(gcf, 'Examples/results/DR_data3_result.png');
