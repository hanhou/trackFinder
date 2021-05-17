function pts=reflectLine(filename)
pts=readBigWarpLandmarks(filename);
lengthPts=length(find(pts(:,1)==Inf));
pts2Change=pts(end-lengthPts+1:end,4:6);
pts2Change(:,1)=-(pts2Change(:,1)-5700)+5700;
replaceLineCsv(filename,size(pts,1)-lengthPts+1:size(pts,1),pts2Change)

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
for i=1:length(lcnt)
    A{lcnt(i)} = sprintf('%s,false,Infinity,Infinity,Infinity,%5.6f,%5.6f,%5.6f', ['Pt-' num2str(lcnt(i)-1)], replacement(i,:));
end
% Write cell A into txt
fid = fopen([AllenToToronto(1:end-4) '.csv'], 'w');
for i = 1:numel(A)
    if A{i+1} == -1
        fprintf(fid,'%s', A{i});
        break
    else
        fprintf(fid,'%s\n', A{i});
    end
end
fclose(fid);