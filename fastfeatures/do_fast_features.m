%% Change these:
% path = 'YOUR_DATA_FOLDER_PATH_HERE';
path = './data/HOF';
%% Load fast features output feature data to matrix
% Return cell array of preprocessed videos from folders in directory 'path'
folders = dir(path);
files = files(4:end); % truncate '.' and '..'
num_files = length(files);

min_x = intmax;
min_y = intmax;

for i = 1:num_files
    filepath = strcat(path, files(i).name);
    data = load_text_data(filepath);
    [x y] = size(data);
    if x < min_x
        min_x = x;
    end
    if y < min_y
        min_y = y;
    end
    data = imresize(data, [min_x, min_y]);
end

%% Classify 
% [accuracy_spatial,spatial_features,spatial_labels]  = train_and_test_svm(simple_actions, 'spatial');

