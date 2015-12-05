path = 'sorted';
% Return cell array of preprocessed videos from directory 'path'
files = dir(path);
files = files(4:end); % truncate '.' and '..' and 'DS thing'
n_files = length(files);
vids = cell(n_files,1);
frameNums = zeros(n_files,1);
display(sprintf('\nCurrently in folder "%s"',path));

min = 200000;
for i=1:n_files,
    currFolder = sprintf('%s/%s', path, files(i).name);
    currMin = min_frames(currFolder);
    if currMin < min,
        currMin = min;
    end
end
