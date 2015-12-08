%% Change these:
% path = 'YOUR_DATA_FOLDER_PATH_HERE';
path = './data/HOF/';
%% Load fast features and process
[features, labels] = process_text_data(path);

%% Classify 
% A =[];
% for i = 1:100
%     accuracy = classify(features, labels);
%     A = [A, accuracy];
% end
% 
% avg_accuracy = mean(A);
% disp(path)
% disp('accuracy')
% disp(avg_accuracy)

%% Get accuracy by action
A1 = [];
A2= [];
A3 = [];
A4 = [];

for i = 1:100
    A = classify(features, labels);
    A1 = [A1, A(1)];
    A2 = [A2, A(2)];
    A3 = [A3, A(3)];
    A4 = [A4, A(4)];
end

a1 = mean(A1);
a2 = mean(A2);
a3 = mean(A3);
a4 = mean(A4);

result = [a1, a2, a3, a4];
disp(result)