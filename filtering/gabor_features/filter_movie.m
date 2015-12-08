%% Change these:
% path = 'YOUR_ACTION_FOLDER_PATH_HERE';
path = '../../actions';

%% Create our spatial gabors
gabor_size = 25;    
lambda = 5;   
theta= [0, pi/2, pi, (2/3)*pi]; 
sigma = 2;    
gamma = .5;   
psi = 0;

simples = cell(1,length(theta));
for i=1:length(theta),
    simples{1,i} = simple_cell(gabor_size, lambda, theta(i), sigma, gamma, psi);
end

%% Create our spatiotemporal gabors
theta = 0;
omega = [-4*pi,-pi/2,pi/2,4*pi]; 

motions = cell(1,length(theta));
for i=1:length(omega),
    motions{1,i} = spatio_temporal(gabor_size, omega(i), lambda, theta, sigma, gamma, psi);
end

%% Load and preprocess the videos
% Return cell array of preprocessed videos from folders in directory 'path'
folders = dir(path);
folders = folders(4:end); % truncate '.' and '..'
num_actions = length(folders);
actions = cell(num_actions,1);
num_frames = cell(num_actions,1);
for i=1:num_actions,
   subfolder = sprintf('%s/%s', path, folders(i).name);
   [actions{i}, num_frames{i}] = load_and_preprocess_folder(subfolder);
end

%% Filter the videos
simple_actions = cell(num_actions,1);
for i=1:num_actions,
    num_vids = length(actions{i});
    curr_action = cell(num_vids,1);
    for j=1:num_vids,
        curr_action{j,1} = apply_filters(actions{i}{j}, simples);
        display(sprintf('Simple filtered video %d of %d in action %d.', j,num_vids,i));
    end
    simple_actions{i} = curr_action;
end

%%
motion_actions = cell(num_actions,1);
for i=1:num_actions,
    num_vids = length(actions{i});
    curr_action = cell(num_vids,1);
    for j=1:num_vids,
        curr_action{j,1} = apply_filters(actions{i}{j}, motions);
        display(sprintf('Motion filtered video %d of %d in action %d.', j,num_vids,i));
    end
    motion_actions{i} = curr_action;
end

%% If you want to watch a video...
% frameNum = num_frames{1}(1);
% for j=1:4,
%     for i=1:frameNum,
%         imagesc(simple_actions{1}{2}(:,:,i,j));
%         pause(0.03);
%     end
% end

%%
% frameNum = num_frames{1}(1);
% for j=1:4,
%     for i=1:frameNum,
%         imagesc(motion_actions{1}{1}(:,:,i,j));
%         pause(0.01);
%     end
% end

%% Save features in case svm fails
% save('spatial_features','simple_actions');
% save('spatiotemp_features','feature_vector');

%% Classify the actions being performed 
[accuracy_spatial,spatial_features,spatial_labels]  = train_and_test_svm(simple_actions, 'spatial');

%%
[accuracy_spatiotemporal,spatiotemp_features,spatiotemp_labels] = train_and_test_svm(motion_actions, 'spatiotemporal');

%%
combined_actions = horzcat(spatial_features, spatiotemp_features);
combined_labels = horzcat(spatial_labels, spatiotemp_labels);
accuracy_combined = train_and_test_svm_combined(combined_actions, combined_labels, 'combined');


%% Extra: Spatial video output (to show for presentation?)
% v = VideoWriter(outputFile_m);
% open(v);
% for f=1:frameNum,
%     frame = mat2gray(filtered_simple(:,:,:,f));
%     writeVideo(v,frame);
% end
% message = sprintf('Video write to file "%s" complete.', outputFile_s);
% display(message);
% close(v);
% 
% %% Spatiotemporal video output
% v2 = VideoWriter(outputFile_m);
% open(v2);
% for f=1:frameNum,
%     frame = mat2gray(filtered_spatio(:,:,:,f));
%     writeVideo(v2,frame);
% end
% message = sprintf('Video write to file "%s" complete.', outputFile_m);
% display(message);
% close(v2);

