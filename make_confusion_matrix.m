function mat=make_confusion_matrix(actual, predicted)
len = size(actual, 1);
mat = zeros(len);

assert(size(actual) == size(predicted));
for ii = 1:length(actual)
   mat(predicted(ii), actual(ii)) =  mat(predicted(ii), actual(ii)) + 1;
end
end