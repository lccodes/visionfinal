function [accuracy, feature_vector] = train_and_test_svm_combined(features,labels,filename)

feature_vector = features;
display(sprintf('Length of our feature vectors is %d\n', length(feature_vector)));
feature_labels = labels;

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
filename_acc = sprintf('%s_accuracy',filename);
filename_feats = sprintf('%s_features',filename);
save(filename_acc,'accuracy');
display('Successfully saved accuracy to a file.');
save(filename_feats,'feature_vector');
display('Successfully saved feature vector to a file.');


