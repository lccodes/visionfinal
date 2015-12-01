function [myVideo, frameNum] = load_and_preprocess_video(path)
% Takes a path to a video and loads it into an array.
% 
% 
% 

display('File being loaded: ');
display(path);
loaded_video = VideoReader(path);

%we need ours to match the annotated movie's size
%annotated is 720 x 576 x 3 x 33763

%1920 x 1080 is our original downloaded dimension
%(resized before loading)

y = loaded_video.Width;
x = loaded_video.Height;
num_frames = int16(fix(loaded_video.FrameRate*loaded_video.Duration));

display(num_frames);
display(x);
display(y);

%hold the contents of the frame to move to cell array
myVideo = zeros(x,y,3,num_frames);

frameNum = 0;
for i=1:num_frames,
    frame = readFrame(loaded_video);
    frameNum = frameNum + 1;
    myVideo(:,:,:,i) = frame;
end
display(frameNum);
success = sprintf('Successfully loaded %d frames',frameNum);
display(success);

end


