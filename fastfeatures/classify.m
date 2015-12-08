function A = classify(features, labels)
n = length(labels);

randomInd = randperm(n);
features = features(randomInd,:);
labels = labels(randomInd);

boundary = floor(n * 0.8);

trainData = features(1:boundary, :);
trainLabels = labels(1:boundary);

testData = features(boundary + 1: n, :);
testLabels = labels(boundary + 1: n);

SVMModel = fitcecoc(trainData, trainLabels);%multiclass
label = predict(SVMModel, testData);

% accuracy = eval_accuracy(testLabels, label);

mat = make_confusion_matrix(testLabels, label);
[row, col] = size(mat);

A = [];
for i = 1:row
    for j = 1:col
        if i == j
            correct = mat(i,j);
        end
    end
    if sum(mat(:,i)) ~= 0
        accuracy = correct/sum(mat(:,i));
    else
        accuracy = 1;
    end
    
    A = [A, accuracy];
end

end