function [lfps,pxx,freq,rmsA]=getLFPFile(loc,nChansInFile,cGoCue)
    f=fopen(loc);
    out=fread(f,'int16');
    lfps=reshape(out,nChansInFile,[]);

    lfps=lfps(1:nChansInFile-1,:)*0.6/512/250*1000000; % convert to uV
    allCh = 1:384;
    badCh = [37 76 113 152 189 228 265 304 341 380]; % reference sites
    allCh = setdiff(allCh,badCh);
    lfps=lfps(allCh,:); % lower number is more ventral in the brain
    
    lfps = bsxfun(@minus, lfps, mean(lfps,1)); % mean subtraction between channels
    lfps = bsxfun(@minus, lfps, mean(lfps,2)); % mean subtraction within a channel
    
    fs = 2500;
    lfps = lowpass(lfps,20,fs); % lowpass (100)
%     lfps = bandpass(lfps,[0.1 20],fs); % bandpass doesn't work (4-10Hz)
%     lfps = downsample(lfps', 10)'; % downsample (to 250Hz)
%     fs = 250;
    
%     lfps=lfps(:,cGoCue/10-3*fs:cGoCue/10); % get only before the go cue
%     lfps=lfps(:,cGoCue/10-1.2*fs:cGoCue/10); % get 1.2 before the go cue
    lfps=lfps(:,cGoCue-1.2*fs:cGoCue); % get 1.2 before the go cue
    [pxx,freq]=pwelch(lfps',256,128,[],fs); % pwelch lfp
    rmsA=rms(lfps,2);
    fclose(f);
end