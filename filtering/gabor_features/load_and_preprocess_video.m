function [myVideo2, frameNum] = load_and_preprocess_video(path)
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
reshapeY = 150;
reshapeX = 1.3*reshapeY;
% max_frames = 40; %%CHANGE
% myVideo2 = zeros(reshapeX,reshapeY,max_frames);
% myVideo = zeros(x,y,num_frames);

frameNum = 0;
for i=1:num_frames,
    frame = mat2gray(readFrame(loaded_video));
    frameNum = frameNum + 1;
%     myVideo2(:,:,i) = frame(:,:,1);
%     myVideo(:,:,:,i) = frame;
    myVideo2(:,:,i) = imresize(myVideo(:,:,1,i),[reshapeX, reshapeY]);
end
display(sprintf('Successfully loaded %d frames',frameNum));

end