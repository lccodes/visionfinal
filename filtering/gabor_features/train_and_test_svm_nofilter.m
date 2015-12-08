function [accuracy, feature_vector, feature_labels] = train_and_test_svm_nofilter(features,filename)
% features{action_type}{video_num}(x,y,color,time,filter)

%% Reshape features into feature vector of x by y by t by filter
feature_size = size(features{1}{1});
x = feature_size(1);
y = feature_size(2);
frames = feature_size(3);

action_types = length(features);
num_videos = 0;
for i=1:action_types,
   num_videos = num_videos + length(features{i}); 
end

vec_length = x*y*frames;
feature_vector = zeros(num_videos,vec_length);

count = 0;
for i=1:action_types,
    curr_vids = length(features{i});
    for j=1:curr_vids, %vids in curr action type
        count = count + 1;
        feature_vector(count,:) = reshape(features{i}{j}, [1,vec_length]);
    end
end
display(sprintf('Length of our feature vectors is %d\n', length(feature_vector)));

curr_vids = length(features{1});
feature_labels = ones(curr_vids,1);
for j=2:action_types,
   curr_vids = length(features{j});
   curr_labels = ones(curr_vids,1)*j;
   feature_labels = vertcat(feature_labels,curr_labels);
end
%%
mySize = size(feature_vector);
perming = randperm(mySize(1,1)); %size of features
feature_vector = feature_vector(perming,:);
feature_labels = feature_labels(perming);

splitMark = floor(mySize*0.8);
train_data = feature_vector((1:splitMark),:); %first 80%
train_labels = feature_labels((1:splitMark),:);
test_data = feature_vector((splitMark+1):end,:); %last 20%
test_labels = feature_labels((splitMark+1):end,:);

svm = fitcecoc(train_data,train_labels);
[pLabel, pScore] = predict(svm,test_data);
accuracy = eval_accuracy(test_labels,pLabel);


%% Save accuracy and features to files
% filename_acc = sprintf('%s_accuracy',filename);
% filename_feats = sprintf('%s_features',filename);
% save(filename_acc,'accuracy');
% display('Successfully saved accuracy to a file.');
% save(filename_feats,'feature_vector');
% display('Successfully saved feature vector to a file.');


