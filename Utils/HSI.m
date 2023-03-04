classdef HSI < handle
    %HSI is a Hyperspectral Image object, which can help you a lot.
    %
    %   HSI - Initialization Function
    %
    %   F - Flatten the 3D data to 2D data.
    %
    %   locate - Return the spectra locate at the given location.
    %
    %   result_reshape - If you use a target detection algorithm and the
    %       result is 1D, you can use this function to reshape the result to
    %       2D image.
    %
    %   See the usages in 'Examples/Basic_Usage.mlx'.
    
    properties
        him
        shape
    end
    
    methods
        function obj = HSI(him)
            % The array him should be a 3D array: [m, n, l].
            % l should be the number of the bands.
            if ischar(him)
                [X, ~] = HSIReader(him);
                obj.him = X;
                obj.shape = size(him);
            elseif length(size(him)) == 3
                obj.him = him;
                obj.shape = size(him);
            else
                error('The input is invaild, it should be the name of the data or a 3D array.')
            end
        end
        
        function X = F(obj)
            % Return a 2D array: [m*n, l].
            X = reshape(obj.him, [], obj.shape(end));
        end
        
        function D = locate(obj, loc, mode)
            % The default mode is '2D':
            % loc should be a 2D array: [num, 2].
            % The shape of D is : [num, l].
            %
            % In '1D' mode, the 3D array is reshaped to 2D.
            % So loc should be an index list: [num , 1].
            % The shape of D is also : [num, l].
            
            if ~exist('mode', 'var')
                mode = '2D';
            end
            
            if strcmp(mode, '1D')
                X = obj.F();
                D = X(loc, :);
            elseif strcmp(mode, '2D')
                [num, dim] = size(loc);
                
                if dim ~= 2
                    error('Location list should be a n*2 array.')
                end
                
                D = zeros([num, obj.shape(end)]);
                for i = 1:num
                    D(i, :) = obj.him(loc(i, 2), loc(i, 1), :);
                end
            else
                error("Pararmeter 'mode' should be '1D' or '2D'.")
            end
        end
        
        function im = result_reshape(obj, y)
            % The detection result y is a 1D array: [m*n, 1].
            % This function will return a image: [m, n].
            im = reshape(y, obj.shape(1:2));
        end
        
        function remove_bands(obj, rm_list)
            % This function is used to remove the bands in rm_list.
            
            all_list = 1:obj.shape(end);
            left_list = setdiff(all_list, rm_list);
            obj.him = obj.him(:, :, left_list);
            obj.shape = size(obj.him);
        end
        
        function preprocess(obj, mode)
            % You can use this function to normalize or standardized the
            % data.
            if ~exist('mode', 'var')
                mode = 'norm';
            end
            
            if strcmp(mode, 'norm')
                m1 = max(obj.him, [], [1, 2]);
                m2 = min(obj.him, [], [1, 2]);
                obj.him = (obj.him - m2) ./ (m1 - m2);
            elseif strcmp(mode, 'std')
                mu = mean(obj.him, [1, 2]);
                sigma = std(obj.him, [], [1, 2]);
                obj.him = (obj.him - mu) ./ sigma;
            else
                error("Pararmeter 'mode' should be 'norm' or 'std'.")
            end
        end
        
        function Y = select_bands(obj, bands, mode)
            % You can use this function to select bands from the whole
            % data. And you can choose '1D' or '2D' mode.
            Y = obj.him(:, :, bands);
            if ~exist('mode', 'var')
                mode = '2D';
            end
            
            if strcmp(mode, '1D')
                Y = reshape(Y, [], length(bands));
            elseif strcmp(mode, '2D')
                return;
            else
                error("Pararmeter 'mode' should be '1D' or '2D'.")
            end
        end
        
        function rgb = rgb(obj)
            % This is a simple function to generate a three-band color
            % composite image.
            
            [m, n, l] = size(obj.him);
            
            X = reshape(obj.him, [], l);
            [Rn, Rs] = noise_signal_estim(obj.him);
            
            Rn_ = pinv(sqrtm(Rn));
            [V, ~, ~] = svd(Rn_' * Rs * Rn_);
            V = Rn_ * V;
            Y = X * V;

            him_ = reshape(Y, [m, n, l]);
            
            idx = FVGBS(him_, [], 3);
            rgb = him_(:, :, idx);
            m1 = max(rgb, [], [1, 2]);
            m2 = min(rgb, [], [1, 2]);
            rgb = (rgb - m2) ./ (m1 - m2);
        end
    end
end

