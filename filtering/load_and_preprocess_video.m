function [myVideo, frameNum] = load_and_preprocess_video(path)
% Takes a path to a video and loads it into an array.

display(sprintf('File being loaded: %s', path));
loaded_video = VideoReader(path);

y = loaded_video.Width;
x = loaded_video.Height;
num_frames = int16(fix(loaded_video.FrameRate*loaded_video.Duration));

% display(num_frames);
% display(x);
% display(y);

%hold the contents of the frame to move to cell array
myVideo = zeros(x,y,3,num_frames);

frameNum = 0;
for i=1:num_frames,
    frame = readFrame(loaded_video);
    frameNum = frameNum + 1;
    myVideo(:,:,:,i) = frame;
end
display(sprintf('Successfully loaded %d frames',frameNum));

end


