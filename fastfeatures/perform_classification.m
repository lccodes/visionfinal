function accuracy = perform_classification(featuremat, labels)
shuffle_order = randperm(length(labels));
shuffled_labels = zeros(size(labels));
shuffled_features = zeros(size(featuremat));

for ii = 1:length(shuffle_order)
    shuffled_labels(ii, 1) = labels(shuffle_order(ii), 1);
    for jj = 1:size(featuremat, 2)
        shuffled_features(ii, jj) = featuremat(shuffle_order(ii), jj);
    end
end

cut_off_index = floor(length(labels) / 10 * 8);
trainData = shuffled_features(1:cut_off_index, :);
testData = shuffled_features(cut_off_index+1:end, :);

trainLabels = shuffled_labels(1:cut_off_index, :);
testLabels = shuffled_labels(cut_off_index+1:end, :);

SVMModel = fitcecoc(trainData, trainLabels);
[label, score] = predict(SVMModel, testData);
accuracy = eval_accuracy(testLabels, label);