rootPath = 'E:\Data_for_ingestion\MAP\SC045\histology';
pattern = {'imec'};
allMatFile = dir(fullfile(rootPath, '*.csv'));

%%
for f = 1:length(allMatFile)
    this = allMatFile(f);
    if ~contains(this.name, pattern, 'IgnoreCase', true)
        continue
    end
    
    % Rename
    name = regexp(this.name,'(?<wr>\w*)_(?<m>\d\d)(?<d>\d\d)(?<y>\d\d)_imec(?<imec>\d+)', 'names');
    newName = sprintf('landmarks_%s_20%s%s%s_%d', name.wr, name.y, name.m, name.d, str2double(name.imec) + 1);
    
    shank = regexp(this.name,'shank(?<shank>\d)', 'names');
    if ~isempty(shank)
        newName = [newName '_' num2str(str2double(shank.shank)+1)];
        npxVersion = 2; % More than one shank, must be 2.0 probe
    else
        npx = regexp(this.name,'npx(?<npx>\d)');
        if isempty(npx)
            npxVersion = 1; % By default, 1.0 probe
        else
            npxVersion = 2;
        end
    end
    
    newName = [newName '.csv'];    
    movefile(fullfile(this.folder, this.name), fullfile(this.folder,newName));
    
    % Do trackFinder
    trackFinder(fullfile(this.folder, newName), [1 2], [1 2], true, npxVersion, false);
    fprintf('Done: %s, npx: %d\n', newName, npxVersion);
    
 end