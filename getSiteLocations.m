function site = getSiteLocations(fn, params)
warp.AtoT = readBigWarpLandmarks(fn.AllenToToronto); % Load the MRI warping
warp.BrainToA = readBigWarpLandmarks(fn.BrainToAllenWithTrack); % Load the brain warping
Ont = importOntology(fn.Ontology); % Load the CCF ontology
% Anno = loadTifFast(fn.AnnotatedBrain); % Load the CCF annotation
Anno = nrrdread(fn.AnnotatedBrain); % Load the CCF annotation
Anno = permute(Anno,[1 3 2]); % Load the CCF annotation

trackix = any(isinf(warp.BrainToA), 2); % The probe track has inf warp in AAT
trackPts = warp.BrainToA(trackix, 4:6);
[~, sort_bottom_to_top] = sort(trackPts(:,2), 'descend');
trackPts = trackPts(sort_bottom_to_top, :);

params1=params; % first get the mapping 1:1, and then scale based on the inputs
params1.ephysAnchors = [1 2];
params1.mriAnchors = [1 2];
[sitePos,warpPos,sfSite]=warpAndSetSites(warp.AtoT,params1,trackPts); % Electrodes in MRI3D

annoPos = round(sitePos./params.AllenPixelSize./1000);
info = getSiteAnnotations(annoPos, Anno, Ont);

origPos = warpToBrainSpace(warp.BrainToA, sitePos); % Electrodes in v3D

site = collectResults(annoPos, warpPos,origPos,info,params,sfSite);

listOfAreas=site.ont.id(~isnan(site.ont.id) & site.ont.id~=0);
info.inBrain = zeros(size(sitePos,1),1);
info.inBrain(1:length(listOfAreas))=1; % # of sites in brain

if sum(params.ephysAnchors-params.mriAnchors)~=0 % only scale and shift if the inputs are different
%     params.TipOffset=length(listOfAreas)/100;
    params.TipOffset=length(listOfAreas)*params.SiteDist; % calculate the tip offset based on number of sites supposed to be in the brain
end
[sitePos,warpPos,sfSite]=warpAndSetSites(warp.AtoT,params,trackPts); % Electrodes in MRI3D

annoPos = round(sitePos./params.AllenPixelSize./1000);
info = getSiteAnnotations(annoPos, Anno, Ont);

origPos = warpToBrainSpace(warp.BrainToA, sitePos); % Electrodes in v3D

site = collectResults(annoPos, warpPos,origPos,info,params,sfSite);

listOfAreas=site.ont.name; emptyAreas=cellfun('isempty',listOfAreas);
listOfAreas=listOfAreas(~emptyAreas);
info.inBrain = zeros(size(sitePos,1),1);
info.inBrain(1:length(listOfAreas))=1; % # of sites in brain

if params.showVis
    renderIn3D(Anno, site);
end

function orig = warpToBrainSpace(warpPts, pos)
trackix = any(isinf(warpPts), 2);
warpPts = warpPts(~trackix, :);
orig = TPS3D(warpPts(:, 4:6), warpPts(:, 1:3), pos);

function renderIn3D(Anno, site)
sc = site.pos.mmPerPixel;
ds = 4;
an = Anno(1:ds:end, 1:ds:end, 1:ds:end);
an = permute(an,[3 2 1]);

xv = 1:ds:size(Anno, 2);
yv = 1:ds:size(Anno, 3);
zv = 1:ds:size(Anno, 1);

figure(1); 
if isempty(findobj(figure(1),'type','axes'))
    subplot(111); axis image;

    p = patch(isosurface(xv.*sc, yv.*sc, zv.*sc, an ,1));
    p.FaceAlpha = 0.05; p.FaceColor = [0 0 0]; p.LineStyle = 'none';

    hold on;
end

listOfAreas=site.ont.name;
emptyAreas=cellfun('isempty',listOfAreas);
listOfAreas=listOfAreas(~emptyAreas);

plot3(site.pos.x(1:length(listOfAreas)).*sc,site.pos.z(1:length(listOfAreas)).*sc,site.pos.y(1:length(listOfAreas)).*sc,'r','lineWidth',1);
% plot3(smoothdata(site.pos.x(1:length(listOfAreas)).*sc,'movmedian',100), smoothdata(site.pos.z(1:length(listOfAreas)).*sc,'movmedian',100), smoothdata(site.pos.y(1:length(listOfAreas)).*sc,100),'k','lineWidth',1);
set(gca, 'Color', 'None', 'ZDir', 'Reverse');
view(51, 14); xlim([0 11.4]); ylim([0 13.2]); zlim([0 8]);

function site = collectResults(annoPts, warpPos, origPos, info, params, sfSite)

site.pos.x = annoPts(:, 1);
site.pos.y = annoPts(:, 2);
site.pos.z = annoPts(:, 3);
site.pos.mmPerPixel = params.AllenPixelSize;

site.warp.x = warpPos(:, 1);
site.warp.y = warpPos(:, 2);
site.warp.z = warpPos(:, 3);

site.orig.x = origPos(:, 1);
site.orig.y = origPos(:, 2);
site.orig.z = origPos(:, 3);

site.ont.row = info.rows;
site.ont.id = info.ids;
site.ont.name = info.names;

site.in.space = info.inSpace;
site.in.brain = zeros(length(info.inSpace),1);
listOfAreas=info.names;
emptyAreas=cellfun('isempty',listOfAreas);
listOfAreas=listOfAreas(~emptyAreas);
site.in.brain(1:length(listOfAreas)) = 1;
site.in.brain=logical(site.in.brain);

site.params = params;

site.sfSite = sfSite;

function info = getSiteAnnotations(pts, Anno, Ont)

inX = pts(:,1)>0 & pts(:,1)<=size(Anno, 2);
inY = pts(:,2)>0 & pts(:,2)<=size(Anno, 1);
inZ = pts(:,3)>0 & pts(:,3)<=size(Anno, 3);
inSpace = inX&inY&inZ;

ixs = sub2ind(size(Anno), pts(inSpace,2), pts(inSpace,1), pts(inSpace,3));
ids = Anno(ixs);
[found, rows] = ismember(ids, Ont.id);
names = cell(size(ids));
names(found) = Ont.name(rows(found));

info.rows = NaN.*zeros(size(pts, 1), 1);
info.ids = NaN.*zeros(size(pts, 1), 1);
info.names = cell(size(pts, 1), 1);

info.rows(inSpace) = rows;
info.ids(inSpace) = ids;
info.names(inSpace) = names;
info.inSpace = inSpace;

function [siteLoc,warpedProbeLoc,sfSite]=warpAndSetSites(warpPts,params,trackPts)

warpedTrack=TPS3D(warpPts(:, 1:3), warpPts(:, 4:6), trackPts); % Allen to MRI
CtrlDist=(sqrt(sum((warpedTrack-repmat(warpedTrack(1,:),size(warpedTrack,1),1)).^2,2))); % dist from the first point

warpedProbeLoc = zeros(params.Nsites, 3);

distance1=diff(params.mriAnchors); % distance in MRI
distanceReal=diff(params.ephysAnchors); % ephys distance
scaleLine=distanceReal./distance1;
scaleLine=[scaleLine(1) scaleLine scaleLine(end)]; % extrapolate first and last
tip=(params.mriAnchors(end)+(384-params.ephysAnchors(end))/scaleLine(end)); % extrapolate the tip in MRI
% tip=(params.mriAnchors(end)+(96-params.ephysAnchors(end))/scaleLine(end)) % extrapolate the tip in MRI

site2scale=fliplr(diff([round(tip)-params.Nsites+1 params.mriAnchors round(tip)]));
site2scale=[0 cumsum(site2scale)]+1;
sfSite=ones(params.Nsites,1);
scaleLine=fliplr(scaleLine);
for i=1:length(site2scale)-1
    sfSite(site2scale(i):site2scale(i+1))=scaleLine(i);
end
% sfSite=flip(sfSite);
for i = 1:params.Nsites
    if isfield(params,'TipOffset')
        dist = (params.TipOffset-tip*params.SiteDist)+(i-1)*params.SiteDist/sfSite(i); % distance to move from tip
%         dist = (params.TipOffset-tip*params.SiteDist)+sum(params.SiteDist/sfSite(1:i-1)); % distance to move from tip
    else
        dist = (i-1)*params.SiteDist; % distance to move from tip
    end
    
    ix1 = find(dist>=CtrlDist, 1, 'last'); % lower point
    ix2 = find(dist<CtrlDist, 1, 'first'); % upper point
    
    if isempty(ix1) % if want to extrapolate the tip
        ix1 = 1;
        ix2 = 2;
    elseif isempty(ix2)
        ix2 = ix1;
        ix1 = ix1-1;
    end
    warpedProbeLoc(i,:)=warpedTrack(ix1,:)+((dist-CtrlDist(ix1))./(CtrlDist(ix2)-CtrlDist(ix1))*(warpedTrack(ix2,:)-warpedTrack(ix1,:)));
end
siteLoc=TPS3D(warpPts(:,4:6),warpPts(:,1:3),warpedProbeLoc); % MRI to AAT

function pts = readBigWarpLandmarks(AllenToToronto)
col = 3:8;

fid = fopen(AllenToToronto);
cnt = 0;
while(~feof(fid))
    fgetl(fid);
    cnt = cnt+1;
end
fclose(fid);

pts = zeros(cnt, numel(col));

fid = fopen(AllenToToronto);
cnt = 0;
while(~feof(fid))
    str = fgetl(fid);
    cnt = cnt+1;
    str = str(str~='"');
    str = strrep(str, 'Infinity', 'Inf');
    elements = strsplit(str, ',');
    pts(cnt, :) = cellfun(@str2num, elements(col));
end
fclose(fid);

function im = loadTifFast(FileTif)
disp(['Loading ' FileTif '...']);
info=imfinfo(FileTif);
xpix=info(1).Width;
ypix=info(1).Height;
frames=numel(info);

bitdepth = info(1).BitsPerSample;
if bitdepth == 32
    im=zeros(ypix,xpix,frames,'uint32');
elseif bitdepth ==16
    im=zeros(ypix,xpix,frames,'uint16');
elseif bitdepth ==8
    im=zeros(ypix,xpix,frames,'uint8');
end
warning off;

TifLink = Tiff(FileTif, 'r');
for i=1:frames
   TifLink.setDirectory(i);
   im(:,:,i)=TifLink.read();
end
TifLink.close();

warning on;
disp('Done loading Tif');


%======================================================
% 3D Thin Plate Spline by Yang Yang (05.05.2012)
% 
%======================================================
function [wobject] = TPS3D(points,ctrlpoints,object)
%======================================================
% Calculate Parameters 
%======================================================
npnts = size(points,1);
K = zeros(npnts, npnts);
for rr = 1:npnts
    for cc = 1:npnts
        K(rr,cc) = sum( (points(rr,:) - points(cc,:)).^2 ); %R^2 
        K(cc,rr) = K(rr,cc);
    end
end
%calculate kernel function R
K = max(K,1e-320);
K = sqrt(K); %
% Calculate P matrix
P = [ones(npnts,1), points]; %nX4 for 3D
% Calculate L matrix
L = [ [K, P];[P', zeros(4,4)] ]; %zeros(4,4) for 3D
param = pinv(L) * [ctrlpoints; zeros(4,3)]; %zeros(4,3) for 3D
%======================================================
% Calculate new coordinates (x',y',z') for each points 
%====================================================== 
pntsNum=size(object,1); 
K = zeros(pntsNum, npnts);
gx=object(:,1);
gy=object(:,2);
gz=object(:,3);
for nn = 1:npnts
    K(:,nn)=(gx-points(nn,1)).^2+(gy-points(nn,2)).^2+(gz-points(nn,3)).^2; % R^2
end
K = max(K,1e-320); 
K = sqrt(K); %|R| for 3D
P = [ones(pntsNum,1), gx, gy, gz];
L = [K, P];
wobject = L * param;  
wobject(:,1)=round(wobject(:,1)*10^3)*10^-3;
wobject(:,2)=round(wobject(:,2)*10^3)*10^-3;
wobject(:,3)=round(wobject(:,3)*10^3)*10^-3;