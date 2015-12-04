function filtered_video = apply_filters(video, filters)
vidDim = size(video);
x = vidDim(1);
y = vidDim(2);
t = vidDim(4);
filtered_video = zeros(x,y,3,t,length(filters));
display(size(filtered_video));
for d=1:length(filters),
    curr = imfilter(video,filters{1,d});
	filtered_video(:,:,:,:,d) = curr;
end
end