%% load the initial params
function [scaleLine,tip]=TrackFinderSF(lineBound,lineBound2,eSite1,eSite2,filename)
    % plot MUA
    % lineBound=1.31; lineBound2=3.03; % dl40/20181022/thal
    % lineBound=1.27; lineBound2=3.10; % dl40/20181024/thal
    % lineBound=1.07; lineBound2=2.77; % dl52/20181008/thal
    % lineBound=1.13; lineBound2=2.92; % dl52/20181010/thal
    % lineBound=1.99; lineBound2=2.89; % dl40/20181013/alm
    % lineBound=1.23; lineBound2=2.66; % dl52/20181013/thal
    % lineBound=1.49; lineBound2=3.34; % dl52/20181015/thal
    
    % calculation of scaling factor
    extraPoints=[eSite1 eSite2 lineBound lineBound2];
    % extraPoints=[251 468 lineBound*100 lineBound2*100]; % point 1,2 of the line dl40/20181022
    % extraPoints=[247 469 127 310]; % point 1,2 of the line dl40/20181024
    % extraPoints=[248 445 107 277]; % point 1,2 of the line dl52/20181008
    % extraPoints=[235 453 115 295]; % point 1,2 of the line dl52/20181010
    % extraPoints=[265 429 124 266]; % point 1,2 of the line dl52/20181013
    % extraPoints=[241 446 149 334]; % point 1,2 of the line dl52/20181015
    % medulla
    % extraPoints=[273 520 117 341]; % point 1,2 of the line tw34/20180716
    % extraPoints=[235 340 101 190]; % point 1,2 of the line tw34/20180717
    % extraPoints=[173 304 70 190]; % point 1,2 of the line dl57/20181114
    % extraPoints=[173 344 73 228]; % point 1,2 of the line dl57/20181115
    % extraPoints=[214 361 103 235]; % point 1,2 of the line dl57/20181116
    % extraPoints=[165 234 90 155]; % point 1,2 of the line dl57/20181117
    % extraPoints=[199 339 107 230]; % point 1,2 of the line dl57/20181118

    point1=extraPoints(1); % point1 of Mike's line; scale the line
    point2=extraPoints(2); % point2 of Mike's line
    distance1=point2-point1; % distance in Mike's line
    pointReal1=extraPoints(3); % point1 of ephys
    pointReal2=extraPoints(4); % point2 of ephys
    distanceReal=pointReal2-pointReal1; % ephys distance
    scaleLine=distanceReal/distance1

    tip = (point2+(3.84-pointReal2)/scaleLine)*scaleLine% extrapolate the tip

    %% save the variables to a .mat file
%     save(filename,'scaleLine','tip')