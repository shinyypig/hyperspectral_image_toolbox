%%
clear; close all;

%%
him = importdata('Indian_pines.mat');

[m, n, l] = size(him);

X = reshape(him, m * n, l);
%%
