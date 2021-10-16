ifFlipLR = true;
rootPath = 'F:\Data_for_ingestion\MAP\HH08\histology';
pattern = {'landmarks'};
allMatFile = dir(fullfile(rootPath, '*.csv'));

%%
for f = 1:length(allMatFile)
    this = allMatFile(f);
    if ~contains(this.name, pattern, 'IgnoreCase', true)
        continue
    end
    
%     name = regexp(this.name,'(?<wr>\w*)_(?<m>\d\d)(?<d>\d\d)(?<y>\d\d)_imec(?<imec>\d+)', 'names');
    % Input name format from BigWarper (all index starts from 1)
    % NP1.0: "landmarks_HH08_20210815_1.csv"
    % NP2.1: "landmarks_HH08_20210814_3_npx21.csv" (to differentiate from NP1.0)
    % NP2.4: "landmarks_HH08_20210824_1_1.csv"
    name = regexp(this.name,'(?<wr>\w*)_(?<y>\d\d\d\d)(?<m>\d\d)(?<d>\d\d)_(?<insertion>\d+)_?(?<shank>(\d|npx.*))?.csv', 'names');
    
    newName = sprintf('%s_%s%s%s_%d', name.wr, name.y, name.m, name.d, str2double(name.insertion));
    
    % Parse npxVersion
    if isempty(name.shank)  % NP1.0
        npxVersion = 1;
    else
        npxVersion = 2;  
        if ~contains(name.shank, 'npx')  % NP2.4        
            newName = [newName '_' name.shank]; % Add shank number to name
        end
    end
    
    newName = [newName '.csv'];    
    
    if ~strcmp(this.name, newName)
        movefile(fullfile(this.folder, this.name), fullfile(this.folder, newName));
    end
    
    % Do trackFinder
    % trackFinder(filename, mriAnchors, ephysAnchors, saveOrNo, npxVersion, reflectOrNo, plotOrNo)
    trackFinder(fullfile(this.folder, newName), [1 2], [1 2], true, npxVersion, ifFlipLR, false);
    fprintf('Done: %s, npx: %d\n', newName, npxVersion);
    
 end