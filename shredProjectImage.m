function [ Cam_im ] = shredProjectImage( rad, bands, resp_fun )
%shredPROJECTTORGB Project a HS image to camera reponse, using a response
%function over a supplied set of bands
%
%   [ Cam_im ] = projectToRGB( ref, bands )
%
%   Requieres: spectral_color_1,roundsd
%
%   Input
%
%   rad     - Hyperspectral image
%   bands   - List of sampled bands
%   resp_fun        - (optional) Response filter to use for reconstruction, defaults to cie color matching function over 'freqs'. Should be of size: size(freqs,1)x3
%
%   Output
%
%   Cam_im  - Projected image

    filter = resp_fun;
    bandcount = max(size(bands));
    if (size(size(rad),2)>2)
        Cam_im = reshape(reshape(rad,[],bandcount)*filter,size(rad,1),size(rad,2),size(filter,2));
    else % hyperspecral "image" given as a column vector
        Cam_im = reshape(reshape(rad,[],bandcount)*filter,size(rad,1),size(filter,2));
    end

    %RGB_im=roundsd(RGB_im,3); % save only 3 Significant digits?
    %RGB_im = round((RGB_im./max(RGB_im(:))).*255);

end

