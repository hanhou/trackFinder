function site=trackFinder(filename,mriAnchors,ephysAnchors,saveOrNo)
% Full path to BigWarp output file
fn.BrainToAllenWithTrack = filename;

% These files need to be in the same directory as the code
fn.AllenToToronto = 'landmarksAllenToToronto.csv';
fn.AnnotatedBrain = 'C:\Users\liul.HHMI\Desktop\trackFinderData\Annotation_new_10_ds222_32bit.tif'; % 2017 v3
fn.Ontology = 'mousebrainontology_2.csv'; % 2017 v3

%all in mm
params.TipOffset = 0.43;
params.SiteDist = 0.01; % site dist
params.ephysAnchors = ephysAnchors;
params.mriAnchors = mriAnchors;
params.AllenPixelSize = 0.02;
params.Nsites = 1000;
params.showVis = 1;

site = getSiteLocations(fn, params); % MRI
% site = getSiteLocationsNoMRI(fn, params); % No MRI
plotAnnotation(site);
if saveOrNo==1
    save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat'], 'site'); % Save site information to a .mat file
%     save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo_noMRI.mat'], 'site'); % Save site information to a .mat file
end
