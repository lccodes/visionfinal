function accuracy = train_and_test_svm(features)
% features{action_type}{video_num}(x,y,color,time,filter)

%% Reshape features into feature vector of x by y by t by filter
feature_size = size(features{1}{1});
x = feature_size(1);
y = feature_size(2);
frames = feature_size(3);
filters = feature_size(4);

action_types = length(features);
num_videos = 0;
for i=1:action_types,
   num_videos = num_videos + length(features{i}); 
end

vec_length = x*y*frames*filters;
feature_vector = zeros(num_videos,vec_length);

count = 0;
for i=1:action_types,
    curr_vids = length(features{i});
    for j=1:curr_vids, %vids in curr action type
        count = count + 1;
        feature_vector(count,:) = reshape(features{i}{j}, [1,vec_length]);
    end
end
display(size(feature_vector));

curr_vids = length(features{1});
feature_labels = ones(curr_vids,1);
for j=2:action_types,
   curr_vids = length(features{i});
   curr_labels = ones(curr_vids,1)*j;
   feature_labels = vertcat(feature_labels,curr_labels);
end
display(size(feature_labels));


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

