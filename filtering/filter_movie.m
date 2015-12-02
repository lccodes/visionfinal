
%% Create our motion gabors
gabor_size = 25; 
omega = [-4*pi,-pi/2,pi/2,4*pi];     
lambda = 5;   
theta= 0; 
sigma = 2;    
gamma = .5;   
psi = [0,pi/2];

gabors = cell(length(omega),1);
for i=1:length(omega),
    gabors{i} = spatio_temporal(gabor_size, omega(i), lambda, theta, sigma, gamma, psi(1));
end

%% Load and preprocess the video
path1 = 'handclapping.mp4'; %%CHANGE
[video1, frameNum1] = load_and_preprocess_video(path1);

path2 = 'handclapping.mp4'; %%CHANGE
[video2, frameNum2] = load_and_preprocess_video(path2);

path3 = 'handclapping.mp4'; %%CHANGE
[video3, frameNum3] = load_and_preprocess_video(path3);

path4 = 'handclapping.mp4'; %%CHANGE
[video4, frameNum4] = load_and_preprocess_video(path4);

% %%
% for i=1:frameNum,
%     % help I don't know how to display an RBG image (just displaying the R)
%     display(i);
%     imagesc(video1(:,:,1,i));
%     pause(0.05);
% end

%% Filter the video and convert output to .AVI
filtered1 = apply_filters(video1, gabors);
filtered2 = apply_filters(video2, gabors);
filtered3 = apply_filters(video3, gabors);
filtered4 = apply_filters(video4, gabors);

% %%
% for i=1:frameNum,
%     % displaying R channel and filter 1
%     imagesc(filtered1(:,:,1,i,1));
%     pause(0.05);
% end

%%
gaborNumber = 1; %we have 8 possible choices of gabor filterings; using #1

v1 = VideoWriter('filtered1.avi');
open(v1);
for f=1:frameNum1,
    frame = mat2gray(filtered1(:,:,:,f,gaborNumber));
    writeVideo(v1,frame);
end
close(v1);

v2 = VideoWriter('filtered2.avi');
open(v2);
for f=1:frameNum1,
    frame = mat2gray(filtered2(:,:,:,f,gaborNumber));
    writeVideo(v2,frame);
end
close(v2);

v3 = VideoWriter('filtered3.avi');
open(v3);
for f=1:frameNum1,
    frame = mat2gray(filtered3(:,:,:,f,gaborNumber));
    writeVideo(v3,frame);
end
close(v3);

v4 = VideoWriter('filtered4.avi');
open(v4);
for f=1:frameNum1,
    frame = mat2gray(filtered4(:,:,:,f,gaborNumber));
    writeVideo(v4,frame);
end
close(v4);

%%


