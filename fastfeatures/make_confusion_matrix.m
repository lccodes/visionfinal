function mat=make_confusion_matrix(actual, predicted)
len = size(actual, 1);
siize = 1;
for ii = 1:len
    if actual(ii) > siize
        siize = actual(ii);
    end
    if predicted(ii) > siize
        siize = predicted(ii);
    end
end
mat = zeros(siize);

% assert(length(actual) == length(predicted));
for ii = 1:length(actual)
   mat(predicted(ii), actual(ii)) =  mat(predicted(ii), actual(ii)) + 1;
end
end