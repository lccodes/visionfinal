path = 'nd';

% % Return cell array of preprocessed videos from directory 'path'
 files = dir(path);
 files = files(3:end); % truncate '.' and '..' and 'DS thing'
 n_files = length(files);
% vids = cell(n_files,1);
% frameNums = zeros(n_files,1);
% display(sprintf('\nCurrently in folder "%s"',path));
% 
% min = intmax;
% for i=1:n_files,
%     currFolder = sprintf('%s/%s', path, files(i).name);
%     currMin = min_frames(currFolder);
%     if currMin < min,
%         min = currMin;
%     end
% end
% 
% display(sprintf('\nFinal min number of frames is "%d"',min));

min = 40;
for i=1:n_files,
    currFolder = sprintf('%s/%s', path, files(i).name);
    trim_frames(currFolder,min);
end

display('Successfully trimmed videos.');