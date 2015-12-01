function simple = spatio_temporal(gabor_size, omega, lambda, theta, sigma, gamma, psi)
%% Building Spatiotemporal Filters
% To prepare for the lab, you'll need to make 3D spatiotemporal filters to
% convolve with input videos. These filters will be similar to static gabor
% filters, with a few slight differences. First, these filters will have a
% time dimension. In other words, our static gabors produced by
% *simple_cell* are a function of x and y, but our spatiotemporal filters
% will be a function of x, y and t. Like *simple_cell*, your spatiotemporal
% filters will have the following parameters: 
%
%   - filter_size
%   - omega (NOTE: new parameter for wavelength along the temporal dimension)
%   - lambda
%   - theta
%   - sigma
%   - gamma
%   - psi
%
% To start, take a look at the equation given in the image 'equation.png.'
% Comment on the new parameters you see and what you suspect their roles
% will be in filtering videos.

% (2pi/w)t is the new term
% w should be a term that adjusts the amount of shift over time
% t should be time in the video
 
% Next, use this equation to fill in *spatio_temporal_template.m*, which
% you can save as *spatio_temporal.m* once you've filled it in. Hint: you
% are encouraged to do this by modifying your code from *simple_cell*.
    

    mag = (gabor_size-1)/2;
    
    % use NaN for a sanity check (in case something didn't get initialized)
    simple = nan(gabor_size, gabor_size, gabor_size);
    
    % get x and y from a lookup table
    mags = -mag:mag;
    % iterate over rows and columns of the matrix
    for jj = 1:gabor_size
        for ii = 1:gabor_size
            for kk = 1:gabor_size %how did we choose t?
                y = mags(jj);
                x = mags(ii);
                t = mags(kk);
                x_ = x*cos(theta) + y*sin(theta);
                y_ = -x*sin(theta) + y*cos(theta);
                new_term = (2*pi/omega)*t;
                simple(jj,ii,kk) = exp(- (x_^2 + gamma^2*y_^2) / (2*sigma^2)) * cos(2*pi*x_/lambda + new_term + psi);
            end
        end
    end

    % Now we make sure that this Gabor filter has zero mean, and one norm
    % You can leave this part unchanged
    simple = simple - mean(simple(:));
    simple = simple / sqrt(sum(simple(:).^2));
end

