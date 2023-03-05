%% 
% Load Indian Pines data and create a HSI(Hyperspectral Image) object.
% 
% We also show the three-band composite color image.

clear, close all;
him = importdata('Data/Indian_pines.mat');

[m, n, l] = size(him);

X = reshape(him, [], l);
d = squeeze(him(49, 24, :))';
%% 
% CEM, MF and SAM are test in this experiment.

y_CEM = CEM(X, d);
y_MF = MF(X, d);
y_SAM = -SAM(X, d);
%% 
im_CEM = reshape(y_CEM, m, n);
im_MF = reshape(y_MF, m, n);
im_SAM = reshape(y_SAM, m, n);
%% 
% Imshow the results.

figure,
subplot(131), imshow(im_CEM, []), title('CEM');
subplot(132), imshow(im_MF, []), title('MF');
subplot(133), imshow(im_SAM, []), title('SAM');
exportgraphics(gcf, 'Examples/results/target_detection.png');
