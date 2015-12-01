
%% Create our motion gabors
% gabor_size = 25; 
% omega = [-4*pi,-pi/2,pi/2,4*pi];     
% lambda = 5;   
% theta=[0, pi/2]; 
% sigma = 2;    
% gamma = .5;   
% psi = [0,pi/2];
% 
% gabors = cell(length(omega),length(theta));
% for i=1:length(omega),
%     for j=1:length(theta),
%         gabors{i,j} = spatio_temporal(gabor_size, omega(i), lambda, theta(j), sigma, gamma, psi(1));
%     end
% end

%% Load and preprocess the video
path = 'handclapping.mp4';
[video, frameNum] = load_and_preprocess_video(path);
%%
for i=1:frameNum,
    % help I don't know how to display an RBG image (just displaying the R)
    display(i);
    imagesc(video(:,:,1,i));
    pause(0.05);
end

%% Filter the video and convert output to .AVI







