%%
% Read 3 images and use them to generate 3 mixed images.

clear; close all;
shape = [256, 256];
im1 = double(imresize(imread('threads.png'), shape));
im2 = double(imresize(imread('text.png'), shape));
im3 = double(imresize(imread('blobs.png'), shape));
im1 = mat2gray(im1);
im2 = mat2gray(im2);
im3 = mat2gray(im3);
X_ = [reshape(im1, [], 1), reshape(im2, [], 1), reshape(im3, [], 1)];
X = X_ * randn(3);
%%
% Three mixed images.

figure;
for i = 1:3
    subplot(1, 3, i), imshow(reshape(X(:, i), shape), []);
end
exportgraphics(gcf, './results/mixed_imgs.png');
sgtitle('Mixed Images');
%%
% The result of PCA.

Y = PCA(X, 3);
figure;
for i = 1:3
    subplot(1, 3, i), imshow(reshape(Y(:, i), shape), []);
end
exportgraphics(gcf, './results/mixed_imgs_pca.png');
sgtitle('PCA');
%%
% The result of FastICA.

Y = FastICA(X, 3);
figure;
for i = 1:3
    subplot(1, 3, i), imshow(reshape(Y(:, i), shape), []);
end
exportgraphics(gcf, './results/mixed_imgs_fastica.png');
sgtitle('FastICA');
%%
% The result of PSA.

Y = PSA(X, 3);
figure;
for i = 1:3
    subplot(1, 3, i), imshow(reshape(Y(:, i), shape), []);
end
exportgraphics(gcf, './results/mixed_imgs_psa.png');
sgtitle('PSA');
%%
% The result of FastICA.

Y = NPSA(X, 3);
figure;
for i = 1:3
    subplot(1, 3, i), imshow(reshape(Y(:, i), shape), []);
end
exportgraphics(gcf, './results/mixed_imgs_npsa.png');
sgtitle('NPSA');
