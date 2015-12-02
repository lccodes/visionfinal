%% Change these:
path = 'YOUR_PATH_HERE';
outputFile = 'FILE_TO_WRITE_TO';

path = 'handclapping.mp4';
outputFile = 'newVid.avi';

%% Create our motion gabors
gabor_size = 25; 
omega = [-4*pi,-pi/2,pi/2,4*pi];     
lambda = 5;   
theta= 0; 
sigma = 2;    
gamma = .5;   
psi = [0,pi/2];

for i=1:length(omega),
    gabor = spatio_temporal(gabor_size, omega(1), lambda, theta, sigma, gamma, psi(1));
end

%% Load and preprocess the video
[video, frameNum] = load_and_preprocess_video(path);

%% Filter the video and convert output to .AVI
filtered_video = imfilter(video,gabor);

%% If you want to watch it...
for i=1:frameNum,
    % displaying R channel
    imagesc(filtered_video(:,:,1,i));
    pause(0.05);
end

%%
v = VideoWriter(outputFile);
open(v);
for f=1:frameNum,
    frame = mat2gray(filtered_video(:,:,:,f));
    writeVideo(v,frame);
end
message = sprintf('Video write to file "%c" complete.', outputFile);
display(message);
close(v);

