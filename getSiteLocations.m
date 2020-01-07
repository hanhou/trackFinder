function site = getSiteLocations(fn, params)

%Load the relevant data
warp.AtoT = readBigWarpLandmarks(fn.AllenToToronto);
warp.BrainToA = readBigWarpLandmarks(fn.BrainToAllenWithTrack);
Ont = importOntology(fn.Ontology);
Anno = loadTifFast(fn.AnnotatedBrain);

%find the coordinates of the track
trackix = any(isinf(warp.BrainToA), 2);
trackPts = warp.BrainToA(trackix, 4:6);

%Put down points in warped space
[sitePos, warpPos, warpDepth] = warpAndSetSites(warp.AtoT, params, trackPts);

annoPos = round(sitePos./params.AllenPixelSize./1000);
info = getSiteAnnotations(annoPos, Anno, Ont);

info.inBrain = warpDepth<params.ManipulatorDepth;

origPos = warpToBrainSpace(warp.BrainToA, sitePos);

site = collectResults(annoPos, warpPos, origPos, info, params, warpDepth);

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

% figure; 
subplot(111); hold on; axis image;

p = patch(isosurface(xv.*sc, yv.*sc, zv.*sc, an ,1));
p.FaceAlpha = 0.05;
p.FaceColor = [0 0 0];
p.LineStyle = 'none';
set(gca, 'Color', [1 1 1], 'ZDir', 'Reverse');

listOfAreas=site.ont.name;
emptyAreas=cellfun('isempty',listOfAreas);
listOfAreas=flipud(listOfAreas(~emptyAreas));

plot3(site.pos.x(1:length(listOfAreas)).*sc, site.pos.z(1:length(listOfAreas)).*sc, site.pos.y(1:length(listOfAreas)).*sc, 'r.');

view(51, 14);


function site = collectResults(annoPts, warpPos, origPos, info, params, warpDepth)

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
site.in.brain = warpDepth<params.ManipulatorDepth;

site.params = params;


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


function [siteLoc, warpedProbeLoc, warpedProbeDepth] = warpAndSetSites(warpPts, params, trackPts)

warpedTrack = TPS3D(warpPts(:, 1:3), warpPts(:, 4:6), trackPts); % Allen to MRI
CtrlDist = (sqrt(sum((warpedTrack-repmat(warpedTrack(1,:), size(warpedTrack, 1), 1)).^2, 2)))*params.ScalingFactor; % dist from the first point

warpedProbeLoc = zeros(params.Nsites, 3);
warpedProbeDepth = zeros(params.Nsites, 1);

for i = 1:params.Nsites
    dist = params.TipOffset+(i-1)*params.Pitch; % distance to move from tip
    warpedProbeDepth(i) = dist;
    
    ix1 = find(dist>=CtrlDist, 1, 'last'); % lower point
    ix2 = find(dist<CtrlDist, 1, 'first'); % upper point
    
    if isempty(ix1) % if want to extrapolate the tip
        ix1 = 1;
        ix2 = 2;
    elseif isempty(ix2)
        ix2 = ix1;
        ix1 = ix1-1;
    end
    warpedProbeLoc(i,:) = warpedTrack(ix1, :) + ((dist-CtrlDist(ix1))./(CtrlDist(ix2)-CtrlDist(ix1))*(warpedTrack(ix2,:) - warpedTrack(ix1, :)));
end
siteLoc = TPS3D(warpPts(:, 4:6), warpPts(:, 1:3), warpedProbeLoc);


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


function ont = importOntology(fn)

fid = fopen(fn);
cnt = 0;
while ~feof(fid)
    str = fgetl(fid);
    cnt = cnt + 1;
end
fclose(fid);

id = zeros(cnt, 1);
info = cell(cnt, 1);

fid = fopen(fn);
cnt = 0;
while ~feof(fid)
    str = fgetl(fid);
    cnt = cnt + 1;
    
    inds = strfind(str, ',');
    
    if ~isempty(inds)
    
    id(cnt) = str2double(str(1:inds(1)-1));
    temp = str(inds(1)+1:end);
    
    temp = temp(temp~='"');
    info{cnt} = temp;
    end

end
fclose(fid);

ont.name = info;
ont.id = id;


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
    K(:,nn) = (gx - points(nn,1)).^2 + (gy - points(nn,2) ).^2 + (gz - points(nn,3) ).^2; % R^2
end
K = max(K,1e-320); 
K = sqrt(K); %|R| for 3D
P = [ones(pntsNum,1), gx, gy, gz];
L = [K, P];
wobject = L * param;  
wobject(:,1)=round(wobject(:,1)*10^3)*10^-3;
wobject(:,2)=round(wobject(:,2)*10^3)*10^-3;
wobject(:,3)=round(wobject(:,3)*10^3)*10^-3;