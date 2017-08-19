% Example code for hyperspectral reconstruction

% Load dependancies, be sure to update the path to point to the location of
% OMP-Box and KSVD-Box.
% Both can be found here: http://www.cs.technion.ac.il/~ronrubin/software.html
addpath('ompbox10');
addpath('ksvdbox13');
assert(exist('omp','file')==2,'OMP-Box not found, cannot continue.');
assert(exist('ksvd','file')==2,'KSVD-Box not found, cannot continue.');

% Load precomputed dicionary
% For any practical purpose, you should generate your own dictionary, based
% on the target domain and RGB/MS camera. See
% 'shredDictionaryGenerationExample.m' for sample dictionary generation
% code.
disp('Loading dictionaries and image');
%load('sample_dict.mat'); % Provides 'Dic_HS' and 'Dic_Cam'

% Load ground truth HS image
load('sample_hs_im.mat'); % Provides 'rad' and 'bands'
%rad=(rad./max(rad(:))).*4095; % "streach" HS image to full luminance range (normalizes brightness compared to the entire BGU DB)

% Load cie 1964 color matching function (target camera);
load('cie_1964_400_700.mat'); % Provides cie_1964

% Apply camera response function to HS data to produce camera response
disp('Preparing simulated camera image');
im_cam = shredProjectImage(rad,bands,cie_1964);

% Reconstrucy HS information from the camera response image
fprintf('Reconstruction HS image from simulated camera image...');
sparsity_target=28; % sparsity target for OMP reconstruction, should usually be identical to the number of target channels in the target camera (i.e. 'no constraint')
rec_hs = shredReconstructImage( im_cam, Dic_Cam, Dic_HS , sparsity_target);
fprintf('Done\n');

% Compute error metrics: avergae RMSE and average RRMSE
RMSE = sqrt(mean((rec_hs(:)-rad(:)).^2));
RMSE = (RMSE./max(rad(:)))*255; %display RMSE on 0-255 scale as in paper
RRMSE = shredRRMSE(rec_hs,rad);
disp(['RMSE: ' num2str(RMSE) '   RRMSE: ' num2str(RRMSE)]);

% Partial visualization of results:
figure(1);
visualized_bands=[7,16,23];
for i=1:3
    subplot(3,3,i);
    imagesc(rad(:,:,visualized_bands(i)));
    title([num2str(bands(visualized_bands(i))) 'nm Ground Truth']);
    colormap bone; axis image;axis off;
    
    subplot(3,3,3+i);
    imagesc(rec_hs(:,:,visualized_bands(i)));
    title([num2str(bands(visualized_bands(i))) 'nm Reconstructed']);
    colormap bone; axis image; axis off;
    
    subplot(3,3,6+i);
    imagesc( ((rad(:,:,visualized_bands(i))-rec_hs(:,:,visualized_bands(i)))./max(rad(:)))*255, [-20 20]  );
    title('Error map');
    axis image; axis off;
end