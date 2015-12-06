function minFrames = trim_frames(path,min)

% Return cell array of preprocessed videos from directory 'path'
files = dir(path);
files = files(4:end); % truncate '.' and '..' and 'DS thing'
n_files = length(files);
display(sprintf('\nCurrently in folder "%s"',path));

    status = mkdir(sprintf('%s/trimmed',path));
    if status==0,
        display('Warning: folder create was unsuccessful');
    end

for i=1:n_files,
    currVid = sprintf('%s/%s', path, files(i).name);
    loaded_video = VideoReader(currVid);
    %get dimensions
    y = loaded_video.Width;
    x = loaded_video.Height;
    num_frames = int16(fix(loaded_video.FrameRate*loaded_video.Duration));
   
    
    if num_frames>min,
        start = floor((num_frames - min)/2)-1;
        if start<1,
            start = 1;
        end

        %store video in matrix
        myVideo = zeros(x,y,min);
        index = 0;
        for j=start:(start+min-1),
    %         display(j);
            index = index+1;
            frame = mat2gray(readFrame(loaded_video));
            myVideo(:,:,index) = frame(:,:,1);
        end

        %save to file
        output_name = sprintf('%s/trimmed/trimmed_%s', path, files(i).name);
        v = VideoWriter(output_name);
        open(v);
        for f=1:min,
            frame = myVideo(:,:,f);
            writeVideo(v,frame);
        end
        display(sprintf('Video write to file "%s" complete.', output_name));
        close(v);
    else
        display(sprintf('Did not use video "%s" because it was too short', currVid));
    end
end

        
end

