clear;
h = HSI(importdata('Data/Indian_pines.mat'));
%%
num = 5;
E = NFINDR(h.F(), num);
plot(E');
%%
P = pinv(E * E') * E * h.F()';
P = reshape(P', [h.shape(1), h.shape(2), num]);
for i = 1:num
    figure, imshow(P(:, :, i), []);
end