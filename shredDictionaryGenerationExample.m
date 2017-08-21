% Example code for dictionary generation
%
% This example code requieres some HS source files from which to create the
% dictionary, we recommend that you use the BGU ICVL HS database, avaiable
% at: http://icvl.cs.bgu.ac.il/hyperspectral

% Directory settings
SOURCE_DIRECTORY = 'C:\Scratch\BGU_HS\'; % Directory where source HS images may be found, HS image expected as 'rad' XxYxN matrix
OMPBOX_PATH='ompbox10';
KSVDBOX_PATH='ksvdbox13';
%OMP-Box and KSVD-Box can be found here: http://www.cs.technion.ac.il/~ronrubin/software.html

% Dictionary generation parameters, adjust for optimal performance.
PIXELS_PER_FILE = 1000; % Amount of pixels to randomly sample from each image.
KSVD_ITERATIONS = 5; % Iterations of the K-SVD algorithm.
DIC_SPARSITY_TARGET = 28; % Sparsity target passed to K-SVD alg' for dictionary generation
DIC_SIZE = 1000; % Dictionary size
KSVD_VERBOSE='irt';

% Source image and target camera properties
cie_1964 = ... % our target camer: the CIE 1964 color matching function
  [0.0191097 0.0020044 0.0860109; 0.084736 0.008756 0.389366; 0.204492 0.021391 0.972542; 0.314679 0.038676 1.55348; 0.383734 0.062077 1.96728; 0.370702 0.089456 1.9948; 0.302273 0.128201 1.74537; 0.195618 0.18519 1.31756; 0.080507 0.253589 0.772125; 0.016172 0.339133 0.415254; 0.003816 0.460777 0.218502; 0.037465 0.606741 0.112044; 0.117749 0.761757 0.060709; 0.236491 0.875211 0.030451; 0.376772 0.961988 0.013676; 0.529826 0.991761 0.003988; 0.705224 0.99734 0; 0.878655 0.955552 0; 1.01416 0.868934 0; 1.11852 0.777405 0; 1.12399 0.658341 0; 1.03048 0.527963 0; 0.856297 0.398057 0; 0.647467 0.283493 0; 0.431567 0.179828 0; 0.268329 0.107633 0; 0.152568 0.060281 0; 0.0812606 0.0318004 0; 0.0408508 0.0159051 0; 0.0199413 0.0077488 0; 0.00957688 0.00371774 0];
bands = 400:10:700; % Bands of HS source image - these must match the HS source images!


% Veirfy directory settingsaddpath(OMPBOX_PATH);
addpath(KSVDBOX_PATH);
assert(exist('omp','file')==2,'OMP-Box not found, cannot continue.');
assert(exist('ksvd','file')==2,'KSVD-Box not found, cannot continue.')
assert(exist(SOURCE_DIRECTORY,'dir')==7,'Source directory not found, cannot continue.');

% Prepare sample pixels for dictionary generation
disp('Collecting HS pixels from sample images...');
files = dir ([SOURCE_DIRECTORY '\*.mat']);
assert(size(files,1)>0,'No HS source files found, cannot continue');
fcount = size(files,1); % file count
pixels = zeros(fcount*PIXELS_PER_FILE,size(bands,2)); % matrix to hold sample pixels
for f=1:fcount
    % nice progress counter
    cc = numel(num2str(fcount));
    if (f>1); for c=1:(2*cc+3); fprintf('\b'); end; end
    fprintf(['%0' num2str(cc) 'd | %0' num2str(cc) 'd' ], f,fcount); 
    if (f==fcount); fprintf('\n'); end
    % end nice progress counter
    clear rad;
    load([SOURCE_DIRECTORY '\' files(f).name],'rad');
    assert(exist('rad','var')==1,['Error: file ' files(f).name ' does not contain a `rad` matrix.']);
    rad = reshape(rad,[],size(bands,2)); % convert HS image to HS pixel vector.
    pixels(1+(f-1)*PIXELS_PER_FILE:f*PIXELS_PER_FILE,:) = rad(randi(size(rad,1),1,PIXELS_PER_FILE),:); % add PIXELS_PER_FILE random pixels from current file to the 'pixels' matrix
end
disp('Done collecting HS pixels from sample images.');
    
% Generat dictionaries
disp('Generating HS and corresponding target camera dictionaries..')
init_dict=[]; %empty initial dictionary.
[Dic_HS, Dic_Cam] = shredMakeDictionaries( pixels, bands,DIC_SPARSITY_TARGET , DIC_SIZE, KSVD_ITERATIONS, KSVD_VERBOSE, init_dict, cie_1964  );
disp('Done');
disp('');
disp('You may now use and/or save Dic_HS and Dic_Cam for hyperspectral reconstruction from your target camera');
