%% Change these:
% path = 'YOUR_DATA_FOLDER_PATH_HERE';
path = './data/HOG/';
%% Load fast features and process
[features, labels] = process_text_data(path);

%% Classify 
A =[];
for i = 1:30
    accuracy = classify(features, labels, 'HOF');
    A = [A, accuracy];
end

avg_accuracy = mean(A);
disp(path)
disp('accuracy')
disp(avg_accuracy)


