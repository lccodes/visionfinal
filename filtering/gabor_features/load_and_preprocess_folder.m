function [vids, frameNums] = load_and_preprocess_folder(path)
% Return cell array of preprocessed videos from directory 'path'
files = dir(path);
files = files(4:end); % truncate '.' and '..' and 'DS thing'
n_files = length(files);
vids = cell(n_files,1);
frameNums = zeros(n_files,1);
display(sprintf('\nCurrently in folder "%s"',path));
display(n_files);

for i=1:n_files,
    currVid = sprintf('%s/%s', path, files(i).name);
    [vids{i,1}, frameNums(i)] = load_and_preprocess_video(currVid);
end

end