%%
% Open it as live script!!!
%%
% Load the indian_pines dataset and use it to initialize a HSI object.

clear;
h = HSI(importdata('Indian_pines.mat'));
disp(h);
%%
% The default method of .preprocess() is 'normalize'.

h.preprocess();
m1 = max(h.him(:, :, 1), [], 'all');
m2 = min(h.him(:, :, 1), [], 'all');
disp(['The max value of the fisrt band is ', num2str(m1), '.']);
disp(['The min value of the fisrt band is ', num2str(m2), '.']);

h.preprocess('std');
sigma = std(h.him(:, :, 1), [], 'all');
mu = mean(h.him(:, :, 1), 'all');
disp(['The standard deviation of the fisrt band is ', num2str(sigma), '.']);
disp(['The mean value of the fisrt band is ', num2str(mu), '.']);
%%
% You can use .rgb() to view the three-band composite image.
%
% The degree parameter indicates the power of noise.
%
% degree = 1 means there is no noise in the data.
%
% The default value of degree is 0.5;

rgb = h.rgb();
imshow(rgb);
%%
% You can use .F() to obtain the 2D array of the data.

X = h.F();
disp(['The size of X is [', num2str(size(X)), '].']);
%%
% You can use .select_bands to obtain the bands you want.

D1 = h.select_bands([1, 2]);
D2 = h.select_bands([1, 2], '1D');
disp(['The size of D1 is [', num2str(size(D1)), '].']);
disp(['The size of D2 is [', num2str(size(D2)), '].']);
%%
% You can use .remove_bands to remove the noisy bands.

fprintf('The number of the bands is %d.', h.shape(end));
rm_list = 1:10;
h.remove_bands(rm_list);
fprintf('The number of the bands is %d.', h.shape(end));
%%
% You can use .locate to obtain the pixel you interested.

loc_1D = [1, 146];
loc_2D = [1, 1; 2, 1];
plot(h.locate(loc_2D)');
plot(h.locate(loc_1D, '1D')');
