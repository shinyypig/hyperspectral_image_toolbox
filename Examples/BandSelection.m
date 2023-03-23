%% initialize
clear; close all;

%% read hsi data
him = double(importdata('Indian_pines.mat'));
him = him ./ max(him, [], [1, 2]);
gt = importdata('Indian_pines_gt.mat');
alg_list = {'ECA', 'EFDPC', 'FVGBS', 'MNBS', 'OPBS'};

%% select 3 bands
num = 3;
sel_lists = cell(1, length(alg_list));
for i = 1:length(alg_list)
    sel_lists{i} = eval([alg_list{i}, '(him, num);']);
end

figure;
for i = 1:length(alg_list)
    subplot(1, length(alg_list), i);
    imshow(him(:, :, sel_lists{i}), []);
    title(alg_list{i});
end
exportgraphics(gcf, 'Examples/results/band_sel_false_rgb.png');

%% classificatoin evaluation
bands = size(him, 3):-20:10;
acc = zeros(length(bands), length(alg_list));

for k = 1:length(bands)
    sel_lists = cell(1, length(alg_list));
    for i = 1:length(alg_list)
        sel_lists{i} = eval([alg_list{i}, '(him, bands(k));']);
    end
    for t = 1:5
        for i = 1:length(alg_list)
            X = him(:, :, sel_lists{i});
            X = reshape(X, [], size(X, 3));
            gt = reshape(gt, size(gt, 1) * size(gt, 2), 1);
            [train_data, val_data, train_label, val_label] = train_val_split(X, gt, 0.4);
            acc(k, i) = acc(k, i) + svm(train_data, val_data, train_label, val_label);
        end
    end
    disp([num2str(k), '/', num2str(length(bands))]);
end
acc = acc / t;
%%
figure, plot(bands, acc);
xlabel('number of selected bands');
ylabel('classification accuracy');
legend(alg_list, 'Location', 'best');
exportgraphics(gcf, 'Examples/results/band_sel_svm_acc.png');
%%
function [train_data, val_data, train_label, val_label] = train_val_split(X, gt, ratio)
    num = max(gt(:));
    train_data = [];
    val_data = [];
    train_label = [];
    val_label = [];

    for i = 1:num
        idx = find(gt == i);
        idx = idx(randperm(length(idx)));
        train_mask = idx(1:round(length(idx) * ratio));
        val_mask = idx(round(length(idx) * ratio) + 1:end);
        train_data = cat(1, train_data, X(train_mask, :));
        val_data = cat(1, val_data, X(val_mask, :));
        train_label = cat(1, train_label, gt(train_mask));
        val_label = cat(1, val_label, gt(val_mask));
    end
end

function acc = svm(train_data, val_data, train_label, val_label)
    model = fitcecoc(train_data, train_label);
    pred = predict(model, val_data);
    acc = sum(pred == val_label) / length(val_label);
end
