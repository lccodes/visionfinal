function [features, labels] = process_text_data(path)

folders = dir(path);
folders = folders(3:end); % truncate '.' and '..'
num_folders = length(folders);

min_h = intmax;
min_w = intmax;

for i = 1:num_folders
    folderpath = strcat(path, folders(i).name);
    action_folders = dir(folderpath);
    action_folders = action_folders(3:end); % truncate '.' and '..'
    num_action_folders = length(action_folders);
    
    for j = 1:num_action_folders
        filepath = strcat(folderpath, '/');
        filepath = strcat(filepath, action_folders(j).name);
        feature = load_text_data(filepath);
        [h, w] = size(feature);

        min_h = min(h, min_h);
        min_w = min(w, min_w);
    end
end

features = [];
labels = [];
label = 1;

for i = 1:num_folders
    folderpath = strcat(path, folders(i).name);
    action_folders = dir(folderpath);
    action_folders = action_folders(3:end); % truncate '.' and '..'
    num_action_folders = length(action_folders);
   
   for j = 1:num_action_folders
        filepath = strcat(folderpath, '/');
        filepath = strcat(filepath, action_folders(j).name);
        feature = load_text_data(filepath);
        feature = imresize(feature, [min_h, min_w]);
        features = [features, feature];
        labels = [labels; label];   
   end
   
   label = label + 1;
end


end