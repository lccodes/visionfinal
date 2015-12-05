function minFrames = min_frames(path)

% Return cell array of preprocessed videos from directory 'path'
files = dir(path);
files = files(4:end); % truncate '.' and '..' and 'DS thing'
n_files = length(files);
vids = cell(n_files,1);
frameNums = zeros(n_files,1);
display(sprintf('\nCurrently in folder "%s"',path));

minFrames = 2000;
for i=1:n_files,
    currVid = sprintf('%s/%s', path, files(i).name);
    display(currVid);
    loaded_video = VideoReader(currVid);
    frames = int16(fix(loaded_video.FrameRate*loaded_video.Duration));
    if frames<minFrames,
        minFrames = frames;
    end
    display(sprintf('%s/%d', 'minFrames is currently', minFrames));
end

