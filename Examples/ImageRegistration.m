%% The following code was written in MATLAB R2020a.
clear; close all;
%% 
% read the image and blur the image with a gaussian function with sigma = 5
im = rgb2gray(mat2gray(imread('Data/hk_sub_image.png')));
step = 7;
sigma = 5;
alpha = step / sigma;
kernel = sqrt(gausswin(2 * step + 1, alpha) * gausswin(2 * step + 1, alpha)');
kernel = kernel / sum(kernel(:));
im = imfilter(im,  kernel);
clear alpha kernel sigma;

%%
% initial the parameters
% the standard deviation of the noise ranges from 0 to 0.2
num = 10;
noise = linspace(0, 0.2, num);
e = zeros(num, 6, 6*6*5);
loc = zeros([2, 6]);

[decimalx, decimaly] = meshgrid(1:step-1);
decimal = [decimalx(:), decimaly(:)];

tic;
for n = 1:num
    count = 1;
    for integer = [0, 5, 10, 15, 20]
        for k = 1:length(decimal)
            % generate the image pair with specific displacments
            [im1, im2] = img_pair_gen(im, step, integer, decimal(k, :));
            % generate the true displacements
            sft = (integer + decimal(k, :)' / step);
            
            % add  zero mean gaussian noise to the two images
            im1_ = im1 + randn(size(im1)) * noise(n);
            im2_ = im2 + randn(size(im2)) * noise(n);
            
            % estimating the displacements
            % IDFT-US
            loc(:, 1) = IDFT_US(im1_, im2_, 20);
            
            % SVD-RANSAC
            loc(:, 2) = SVD_RANSAC(im1_, im2_);
            
            tmp = CSM(im1_, im2_, 3);
            % Stone
            loc(:, 3) = tmp(1, :);
            % CSM(3)
            loc(:, 4) = tmp(3, :);
            
            tmp = ANCPS(im1_, im2_, 3);
            % ANCPS(1)
            loc(:, 5) = tmp(1, :);
            % ANCPS(3)
            loc(:, 6) = tmp(3, :);
            
            % record the error
            for i = 1:6
                e(n, i, count) = norm(loc(:, i) - sft);
            end
            count = count + 1;
        end
    end
disp([num2str(n / num * 100), '%']);
end
toc;

%% 
% plot the results
name_list = {'IDFT-US' 'SVD-RANSAC' 'Stone' 'CSM(3)'   'ANCPS(1)', 'ANCPS(3)'};
color_list = lines;
color_list = color_list([1, 4:6, 2, 3], :);
marker_list = 'osd^ph';
set(0, 'DefaultAxesFontSize', 16);
set(0, 'DefaultLineLineWidth', 2);

e_mean = mean(e, 3);
e_max = max(e, [], 3);
e_std = std(e, [], 3);

scnsize = get(0, 'ScreenSize');
w = scnsize(3);
h = scnsize(4);
figure('Position', [w/2-w/3 h/2-w/9 2*w/3 2*w/9]);
subplot(1, 3, 1), hold on;
for i = 1:6
    plot(noise, e_mean(:, i), [marker_list(i), '-'], 'MarkerSize', 8, 'Color', color_list(i, :));
end
axis square;
legend(name_list, 'Location', 'northwest');
box on;
grid on;
xlabel('\sigma_n');
ylabel('mean error');
hold off;

subplot(1, 3, 2), hold on;
for i = 1:6
    plot(noise, e_max(:, i), [marker_list(i), '-'], 'MarkerSize', 8, 'Color', color_list(i, :));
end
axis square;
legend(name_list, 'Location', 'northwest', 'FontSize', 16);
box on;
grid on;
xlabel('\sigma_n');
ylabel('max error');
hold off;

subplot(1, 3, 3), hold on;
for i = 1:6
    plot(noise, e_std(:, i), [marker_list(i), '-'], 'MarkerSize', 8, 'Color', color_list(i, :));
end
axis square;
legend(name_list, 'Location', 'northwest', 'FontSize', 16);
box on;
grid on;
xlabel('\sigma_n');
ylabel('std error');
hold off;