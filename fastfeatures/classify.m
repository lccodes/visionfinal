function accuracy = classify(features, labels)
n = length(lables);

randomInd = randperm(numImages);
features = features(randomInd,:);
labels = labels(randomInd);

boundary = floor(n * 0.8);

trainData = features(1:boundary, :);
trainLabels = labels(1:boundary);

testData = features(boundary + 1: n, :);
testLabels = labels(boundary + 1: n);

SVMModel = fitcsvm(trainData, trainLabels);
[label, score] = predict(SVMModel, testData);
accuracy = eval_accuracy(testLabels, label);
end