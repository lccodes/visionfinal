function [labels, mat] = read_fast_features(path)
    mat = [];
    labels = [];
    
    files = dir(path);
    files = files(3:end); % truncate '.' and '..'
    n_files = length(files);
    label = 0;
    
    hof_max = 189980;
    hog_max = 170660;
    hof_hog_max = 344540;
    
    for ii = 1:n_files
        subpath = [path '/' files(ii).name];
        sub_files = dir(subpath);
        sub_files = sub_files(3:end); % truncate '.' and '..'
        sub_n_files = length(sub_files);
        for jj = 1:sub_n_files
            datapath = [subpath '/' sub_files(jj).name]
            data = importdata(datapath);
            [x, y] = size(data);
            data = reshape(data, [1, x*y]);
            
%             if x*y  < hof_max
%                 data = [data zeros(1, hof_max - x*y)];
%             end
%             if x*y  < hog_max
%                 data = [data zeros(1, hog_max - x*y)];
%             end
             if x*y  < hof_hog_max
                 data = [data zeros(1, hof_hog_max - x*y)];
             end
            labels = cat(2,labels, [label]);
            mat = cat(1, mat, data);
        end
        label = label + 1;

    end
    labels = labels';
end