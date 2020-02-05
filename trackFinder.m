function trackFinder(filename)
%Full path to BigWarp output file
fn.BrainToAllenWithTrack = filename;
% fn.BrainToAllenWithTrack = 'X:\users\Mike\Projects\MAP\Susu-test\sctest_withTrack.csv';
% fn.BrainToAllenWithTrack = 'X:\users\Mike\Projects\MAP\tw35_reg\tw34RegToAllen_withSampleTracks.csv';
% fn.BrainToAllenWithTrack = 'F:\dl51\dl40\dl40landmarksRightTrack1.csv'; % 5.07
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksRightTrack3.csv'; % 5.22
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksRightTrack5.csv'; % 5.05
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack1.csv'; % 5.17
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack1.csv'; % 5
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack3.csv'; % 5
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack5.csv'; % 5.1
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\dl40landmarksRightTrack1alm.csv'; % 2
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksRightTrack3alm.csv'; % 1.97
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksRightTrack5alm.csv'; % 1.91
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack1alm.csv'; % 1.68
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack3alm.csv'; % 1.89
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack5alm.csv'; % 1.95
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks3_withSampleTrack.csv'; % 5
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks4_withTrack1right.csv'; % 5
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks3_withTrack3right.csv'; % 5.24
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks4_withTrack4right.csv'; % 5.04
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks4_withTrack5right.csv'; % 5
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks4_withTrack2ALMright.csv'; % 1.6
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks4_withTrack4ALMright.csv'; % 1.6
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks4_withTrack5ALMright.csv'; % 2.1
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\tw34\landmarks4_withTrackALMleft.csv'; % 2
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack1.csv'; % 4.17
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack2.csv'; % 4.13
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack3.csv'; % 4.11
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack4.csv'; % 4.2
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack1.csv'; % 4.07
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack2.csv'; % 4.2
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack3.csv'; % 3.95
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack4.csv'; % 4.2
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack1ALM.csv'; % 1.68
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack2ALM.csv'; % 1.77
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack3ALM.csv'; % 1.89
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_leftTrack4ALM.csv'; % 1.89
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack1ALM.csv'; % 1.78
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack2ALM.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack3ALM.csv'; % 1.81
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl59\landmarks_rightTrack4ALM.csv'; % 1.82
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_leftTrack1.csv'; % 5.1
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_leftTrack3.csv'; % 5
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_rightTrack1.csv'; % 5.13
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_rightTrack3.csv'; % 5
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_leftTrack1ALM.csv'; % 1.8
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_leftTrack3ALM.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_rightTrack1ALM.csv'; % 2
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl52\landmarks_rightTrack3ALM.csv'; % 1.87
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track1.csv'; % 4.72
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track2.csv'; % 4.84
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track3.csv'; % 4.6
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track4.csv'; % 4.8
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track5.csv'; % 4.43
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarksRight.csv'; % 5.0009
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track1ALM.csv'; % 1.89
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track2ALM.csv'; % 1.93
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track3ALM.csv'; % 1.9
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track4ALM.csv'; % 2.03
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl57\landmarks_Track5ALM.csv'; % 1.91
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_right1.csv'; % 4.42
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_right2.csv'; % 4.44
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_right3.csv'; % 4.42
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_right4.csv'; % 4.44
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_rightALM.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarksLeft.csv'; % 4.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_left1ALM.csv'; % 1.55
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_left2ALM.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl56\landmarks_left3ALM.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_lALM_1.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_lALM_2.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_lALM_4.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_lALM_5.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_rALM_1.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_rALM_2.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_rALM_3.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_rALM_4.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_rALM_5.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_lstr_1.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_lstr_2.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\sc17\landmarks_lstr_3.csv'; % 1.67
% fn.BrainToAllenWithTrack = 'F:\3rd\dl78_20190611.csv';
% fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_test.csv';
% fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_20190613.csv'; % 4.620
% fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_20190616.csv';
% fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_20190612.csv';
% fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_20190617.csv';
% fn.BrainToAllenWithTrack = 'I:\dl79\landmarks_20190716.csv';
% fn.BrainToAllenWithTrack = 'F:\dl79\landmarks_20190715.csv';
% fn.BrainToAllenWithTrack = 'F:\dl79\landmarks_20190719.csv';
% fn.BrainToAllenWithTrack = 'F:\dl79\landmarks_20190719_2.csv';
% fn.BrainToAllenWithTrack = 'F:\dl79\landmarks_20190717.csv';
% fn.BrainToAllenWithTrack = 'F:\dl79\landmarks_20190717_3.csv';
% fn.BrainToAllenWithTrack = 'F:\dl79\landmarks_20190718_2.csv';
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191115_1.csv'; % 3.8472
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191115_2.csv'; % 3.8469
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191116_1.csv'; % 3.8802
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191116_2.csv'; % 3.7923
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191116_3.csv'; % 3.8228
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191116_4.csv'; % 3.8368
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191117_1.csv'; % 3.8802
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191117_2.csv'; % 3.7923
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191117_3.csv'; % 3.8228
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191117_4.csv'; % 4.8668
% fn.BrainToAllenWithTrack = 'H:\a3d\dl81\landmarks_20191117_5.csv'; % 4.7624

% These files need to be in the same directory as the code
fn.AllenToToronto = 'landmarksAllenToToronto.csv';
fn.AnnotatedBrain = 'C:\Users\liul.HHMI\Desktop\trackFinderData\Annotation_new_10_ds222_32bit.tif'; % 2017 v3
fn.Ontology = 'mousebrainontology_2.csv'; % 2017 v3

%all in mm
params.TipOffset = 0.2;
params.SiteDist = 0.01; % site dist
params.ScalingFactor = 1;
params.AllenPixelSize = 0.02;
params.Nsites = 1000;
params.showVis = 1;

site = getSiteLocations(fn, params); % Do all of the hard work
% save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat'], 'site'); % Save site information to a .mat file
% plotAnnotation([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat']);

% load([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat'], 'site'); % CCF distance
% listOfAreas=site.ont.name;
% emptyAreas=cellfun('isempty',listOfAreas);
% listOfAreas=flipud(listOfAreas(~emptyAreas));
% distanceS=zeros(length(listOfAreas)-1,1);
% for i=1:length(listOfAreas)-1
%     distanceS(i)=sqrt((site.pos.x(i)-site.pos.x(i+1)).^2+(site.pos.y(i)-site.pos.y(i+1)).^2+(site.pos.z(i)-site.pos.z(i+1)).^2);
% end
% (length(listOfAreas)-20)/100
% sum(distanceS)*0.02-0.2