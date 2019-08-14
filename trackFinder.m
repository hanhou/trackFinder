function trackFinder(filename)
% clear; clc; close all;

%Full path to BigWarp output file
% fn.BrainToAllenWithTrack = 'X:\users\Mike\Projects\MAP\Susu-test\sctest_withTrack.csv';
% fn.BrainToAllenWithTrack = 'X:\users\Mike\Projects\MAP\tw35_reg\tw34RegToAllen_withSampleTracks.csv';
% fn.BrainToAllenWithTrack = 'F:\dl51\dl40\dl40landmarksRightTrack1.csv'; % 5.07
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksRightTrack3.csv'; % 5.22
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksRightTrack5.csv'; % 5.05
% fn.BrainToAllenWithTrack = 'T:\MAP\imaging\dl40\newMRI\dl40landmarksLeftTrack1.csv'; % 5.17

% fn.BrainToAllenWithTrack = filename;
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
% fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_20190613.csv';
fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_20190616.csv';
% fn.BrainToAllenWithTrack = 'F:\test_5\landmarks_20190616_rev.csv';

%These files need to be in the same directory as the code
fn.AllenToToronto = 'landmarksAllenToToronto.csv';
fn.AnnotatedBrain = 'C:\Users\liul.HHMI\Desktop\trackFinderData\Annotation_new_10_ds222_16bit.tif';
fn.Ontology = 'mousebrainontology_name.csv';

%all in mm
params.ManipulatorDepth = 1.93;
params.TipOffset = 0;
params.Pitch = 0.01;
params.AllenPixelSize = 0.02;
params.Nsites = 1000;
params.showVis = 1;

%Do all of the hard work
site = getSiteLocations(fn, params);

%Save stuff to .mat and .csv files (BigWarp format)
save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat'], 'site');
writeBigWarp(fn.BrainToAllenWithTrack, site);

lcnt=writeRevCsv(fn.BrainToAllenWithTrack);
fn.BrainToAllenWithTrack = [fn.BrainToAllenWithTrack(1:end-4) '_Rev.csv'];
%Do all of the hard work
site = getSiteLocations(fn, params);

%Save stuff to .mat and .csv files (BigWarp format)
save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat'], 'site');
writeBigWarp(fn.BrainToAllenWithTrack, site);

site=load([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat']); % get the whole track
listOfAreas=site.site.ont.name;
emptyAreas=cellfun('isempty',listOfAreas);
listOfAreas=listOfAreas(~emptyAreas);
tip=length(listOfAreas);
M = dlmread([fn.BrainToAllenWithTrack(1:end-4) '_OriginalToAllenSites.csv'],',',[tip-1 5 tip-1 7]);
fn.BrainToAllenWithTrack = [fn.BrainToAllenWithTrack(1:end-8) '.csv'];
replaceLineCsv(fn.BrainToAllenWithTrack,lcnt,M)
fn.BrainToAllenWithTrack = [fn.BrainToAllenWithTrack(1:end-4) '_Whole.csv'];
%Do all of the hard work
site = getSiteLocations(fn, params);

%Save stuff to .mat and .csv files (BigWarp format)
save([fn.BrainToAllenWithTrack(1:end-4) '_siteInfo.mat'], 'site');
writeBigWarp(fn.BrainToAllenWithTrack, site);


function writeBigWarp(fn, site)
use = site.in.brain;
moving = [site.pos.x(use) site.pos.y(use) site.pos.z(use)].*site.pos.mmPerPixel.*1000;
fixed = [site.warp.x(use) site.warp.y(use) site.warp.z(use)];

writeBigWarpLandmarks([fn(1:end-4) '_AllenToTorontoSites.csv'], moving, fixed);

moving = [site.orig.x(use) site.orig.y(use) site.orig.z(use)];
fixed = [site.pos.x(use) site.pos.y(use) site.pos.z(use)].*site.pos.mmPerPixel.*1000;

writeBigWarpLandmarks([fn(1:end-4) '_OriginalToAllenSites.csv'], moving, fixed);


function writeBigWarpLandmarks(outfn, moving, fixed)

fid = fopen(outfn, 'w+');
pos = [moving fixed];

for i = 1:size(pos, 1)
    dat = pos(i, :);
    fprintf(fid, '%s,true,%f,%f,%f,%f,%f,%f\n', ['Pt-' num2str(i)], dat);
end
fclose(fid);


function lcnt=writeRevCsv(AllenToToronto)
col = 3:8;

fid = fopen(AllenToToronto);
cnt = 0;
lcnt = 0;
while(~feof(fid))
    str = fgetl(fid);
    cnt = cnt+1;
    str = str(str~='"');
    elements = strsplit(str, ',');
    if strcmp(elements(3),'Infinity')
        lcnt = cnt;
        break
    end
end
fclose(fid);

M = dlmread(AllenToToronto,',',[lcnt-1 5 lcnt length(elements)-1]);

pts = zeros(lcnt-1, numel(col));

fid = fopen(AllenToToronto);
for i=1:lcnt-1
    str = fgetl(fid);
    str = str(str~='"');
    elements = strsplit(str, ',');
    pts(i, :) = cellfun(@str2num, elements(col));
end
fclose(fid);

fid = fopen([AllenToToronto(1:end-4) '_Rev.csv'], 'w+');
for i = 1:size(pts, 1)
    dat = pts(i, :);
    fprintf(fid, '%s,true,%.9f,%.9f,%.9f,%5.6f,%5.6f,%5.6f\n', ['Pt-' num2str(i-1)], dat);
end
fprintf(fid, '%s,true,Infinity,Infinity,Infinity,%5.6f,%5.6f,%5.6f\n', ['Pt-' num2str(lcnt-1)], M(2,:));
fprintf(fid, '%s,true,Infinity,Infinity,Infinity,%5.6f,%5.6f,%5.6f\n', ['Pt-' num2str(lcnt)], M(1,:));
fclose(fid);


function replaceLineCsv(AllenToToronto,lcnt,replacement)
% Read txt into cell A
fid = fopen(AllenToToronto,'r');
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
fclose(fid);
% Change cell A
A{lcnt} = sprintf('%s,true,Infinity,Infinity,Infinity,%5.6f,%5.6f,%5.6f', ['Pt-' num2str(lcnt-1)], replacement);
% Write cell A into txt
fid = fopen([AllenToToronto(1:end-4) '_Whole.csv'], 'w');
for i = 1:numel(A)
    if A{i+1} == -1
        fprintf(fid,'%s', A{i});
        break
    else
        fprintf(fid,'%s\n', A{i});
    end
end