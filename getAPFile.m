function [aps,muaSum]=getAPFile(loc,nChansInFile,cGoCue,badCh)
    f=fopen(loc);
    out=fread(f,'int16');
    aps=reshape(out,nChansInFile,[]);

    aps=aps(1:nChansInFile-1,:)*0.6/512/500*1000000; % gain adjustment (uV)
    allCh = 1:384;
%     badCh = [badCh 37 76 113 152 189 228 265 304 341 380]; % reference sites
    allCh = setdiff(allCh,badCh);
    aps=aps(allCh,:); % lower number is more ventral in the brain

    fs = 30000;    
%     aps=aps(:,cGoCue-3*fs:cGoCue); % get only 3s before the go cue
    aps=aps(:,cGoCue-98*fs:cGoCue); % get 98s before the go cue
%     aps=aps(:,cGoCue+1.2*fs:cGoCue+4.2*fs); % get only 3s after the go cue
%     aps=aps(:,cGoCue-1.2*fs:cGoCue); % full delay stim
%     aps=aps(:,cGoCue-1.2*fs:cGoCue-0.7*fs); % early delay stim
%     aps=aps(:,cGoCue-1.02*fs:cGoCue-.97*fs); % 3 pulses for the stim exp
%     aps=aps(:,cGoCue-.82*fs:cGoCue-.77*fs); % 3 pulses for the stim exp
%     aps=aps(:,cGoCue-.62*fs:cGoCue-.57*fs); % 3 pulses for the stim exp
    
    aps = bsxfun(@minus, aps, mean(aps,1)); % mean subtraction between channels
    aps = bsxfun(@minus, aps, mean(aps,2)); % mean subtraction within a channel

%     aps=aps./std(aps,0,2); % aps threshold
    
    aps2=[aps(:,2:end) zeros(size(aps,1),1)];
    muaSum=zeros(1,size(aps,1));
    
%     fs=250;
%     threshold=-50;
%     threshold=-5; % z score
    threshold=-100;
    for i=1:size(aps,1) % get the number of threshold events per channel
        spikeLet=find(aps(i,:)>threshold & aps2(i,:)<threshold);
%         muaSum(i)=length(find(spikeLet>cGoCue-1.2*fs & spikeLet<cGoCue-0*fs));
        muaSum(i)=length(spikeLet);
    end
%     aps = abs(bandpass(aps,[300 5000],fs)); % bandpass (300-5000) then full rectification
%     aps = lowpass(aps,100,fs); % lowpass (5000)
%     aps = downsample(aps', 120)'; % downsample (to 250Hz)
%     fs = 250;
%     aps = bandpass(aps,[300 5000],fs); % bandpass (300-5000) for display
%     aps = downsample(aps', 3)'; % downsample (to 10000Hz)
    fclose(f);
end