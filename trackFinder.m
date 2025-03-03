function site=trackFinder(filename, mriAnchors, ephysAnchors, saveOrNo, npxVersion, reflectOrNo, plotOrNo)
if nargin < 5 ;npxVersion = 1; end
if nargin < 6 ;reflectOrNo = false; end
if nargin < 7 ;plotOrNo = true; end

% Full path to BigWarp output file
fn.BrainToAllenWithTrack = filename;

% These files need to be in the same directory as the code
fn.AllenToToronto = 'landmarksAllenToToronto.csv';
fn.AnnotatedBrain = 'annotation_25.nrrd'; % nrrd
% fn.AnnotatedBrain = 'C:\Users\liul.HHMI\Desktop\trackFinderData\Annotation_new_10_ds222_32bit.tif'; % 2017 v3
% fn.AnnotatedBrain = 'C:\Users\liul.HHMI\Desktop\trackFinderData\Annotation_new_25_32bit.tif'; % 2017 25um
% fn.AnnotatedBrain = 'C:\Users\liul.HHMI\Desktop\trackFinderData\Reslice of annotation_10-1.tif'; % 2015 v1
fn.Ontology = 'mousebrainontology_2.csv'; % 2017 v3

%all in mm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if npxVersion == 1
    params.SiteDist = 0.01; % site dist NP1 (mm; assumed spacing between sites in MRI space)
    params.Nsites = 960; % (number of sites on the probe)
else
    params.SiteDist = 0.0075; % site dist NP2
    params.Nsites = 1280; % (number of sites on the probe)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params.mriAnchors = mriAnchors; % the landmarks we look for (in electrode number along the probe, larger number is more ventral)
params.ephysAnchors = ephysAnchors; % the landmarks we look for on the probe (in electrode number, 384 is hardcode to the the tip of the probe) 
params.AllenPixelSize = 0.025; % (mm)
params.showVis = 1; % show the visualization in CCF

% Reflect L and R if needed
% Reflect
if reflectOrNo
    reflectLine(filename);  
end

site = getSiteLocations(fn, params); % MRI
% site = getSiteLocationsNoMRI(fn, params); % No MRI

if plotOrNo
    plotAnnotation(site);
end

if saveOrNo==1
    save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat'], 'site'); % Save site information to a .mat file
%     save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo_noMRI.mat'], 'site'); % Save site information to a .mat file
end
