function [X, param] = HSIReader(filename)
    [filepath, name, ~] = fileparts(filename);
    
    if isempty(filepath)
        filepath = '.';
    end
    data_list = dir([filepath, filesep, name, '*']);
    
    if length(data_list) ~= 2
        error("Can't find the data file or there are more than one data file.");
    end

    for i = 1:2
        if ~strcmp(data_list(i).name(end-3:end), '.hdr')
            dataname = [data_list(i).folder, filesep, data_list(i).name];
            break;
        end
    end
    
    hdrname = [filepath, filesep, name, '.hdr'];
    txt = fileread(hdrname);
    txt = split(txt, {newline});
    
    datatype = {'uint8', 'int16', 'int32', ...
        'float', 'double', 'float',...
        '', '', 'double',...
        '', '', 'uint16',...
        'uint32', 'uint64', 'int64'};
    byteorder = 'ieee-le';
 
    for i = 1:length(txt)
        line_str = char(txt(i));
        if contains(line_str, '=')
            tmp = split(line_str, {'='});
            param_name = char(tmp(1));
            param_name(isspace(param_name)) = [];
            param_value = str2num(char(tmp(end)));
            
            if strcmpi(param_name, 'samples')
                samples = param_value;
            elseif strcmpi(param_name, 'lines')
                lines = param_value;
            elseif strcmpi(param_name, 'bands')
                bands = param_value;
            elseif strcmpi(param_name, 'headeroffset')
                offset = param_value;
            elseif strcmpi(param_name, 'datatype')
                precision = char(datatype(param_value));
            elseif strcmpi(param_name, 'interleave')
                if contains(char(tmp(end)), 'bsq', 'IgnoreCase', true)
                    interleave = 'bsq';
                elseif contains(char(tmp(end)), 'bil', 'IgnoreCase', true)
                    interleave = 'bil';
                elseif contains(char(tmp(end)), 'bip', 'IgnoreCase', true)
                    interleave = 'bip';
                else
                    error('Unknown interleave type.');
                end
            elseif strcmpi(param_name, 'byteorder')
                if param_value
                    byteorder = 'ieee-be';
                else
                    byteorder = 'ieee-le';
                end
            end
        end
    end

    X = multibandread(dataname, [lines, samples, bands], ...
        precision, offset, interleave, byteorder);
    param.lines = lines;
    param.samples = samples;
    param.bands = bands;
    param.precision = precision;
    param.offset = offset;
    param.interleave = interleave;
    param.byteorder = byteorder;
end