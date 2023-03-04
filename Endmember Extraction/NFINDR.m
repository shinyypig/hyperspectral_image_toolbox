function E = NFINDR(X, num)
    %NFINDR is used to extract endmembers
    % X should be a 2D matrix
    % num is the number of the endmembers
    
    [len, l] = size(X);
    loc_list = randi(len, [num, 1]);

    E = X(loc_list, :);
    E = [E, ones([length(loc_list), 1])];
    volume = sqrt(det(E * E' / l));

    for i = 1:num
        tmp_list = loc_list;
        for j = 1:len
            tmp_list(i) = j;
            E = X(tmp_list, :);
            E = [E, ones([length(loc_list), 1])];
            tmp = sqrt(det(E * E' / l));
            if tmp > volume
                volume = tmp;
                loc_list(i) = j;
            end
        end
    end

    E = X(loc_list, :);
end
