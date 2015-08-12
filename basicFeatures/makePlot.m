%% This script generates a visualization of the data for the subject specified by filename.
clear all; close all;

fileName = 'Dog_1';
% Select file path based on operating system.
if(ispc)
    x = strcat('K:\eecs498\data\chrlesc\Subjects\',fileName,'\');
else
    x = strcat('/afs/umich.edu/class/eecs498/data/chrlesc/Subjects/',fileName,'/');
end

% Read the filenames from disk.
preictalClips = dir([x '*_preictal_*.mat']);
interIctalClips = dir([x '*_interictal_*.mat']);
testClips = dir([x '*_test_*.mat']);
prevSequence = 2;
prevMax = 0;
for i = 1:2
    % Parse the data structure.
    file = load([x preictalClips(1).name]);
    names = fieldnames(file);
    thisFile = file.(names{1});
    data = thisFile.data;
    channels = size(data,1);
    pw = floor(sqrt(channels));
    ph = ceil(channels/pw);
    T = 1/thisFile.sampling_frequency;
    newMax = (length(data)*T)-T+prevMax;
    t = prevMax:T:newMax;
    % Create an equiripple bandpass filter and remove the trendline from the data,
    % ie. Normalize the data to the mean.
    d = fdesign.bandstop('N,Fp1,Fst1,Fst2,Fp2,C',100,50,55,65,70,1/T);
    d.Passband1Constrained = true; d.Apass1 = 0.5;
    d.Passband2Constrained = true; d.Apass2 = 0.5;
    Hd = design(d,'equiripple');
    data2 = filter(Hd,data);
    data2 = detrend(data2')';
    for n = 1:channels
        figure(1);
        subplot(ph,pw,n);
        hold on;
        title(sprintf('Channel %d',n));
        
        plot(t,data(n,:));
        figure(2);
        subplot(ph,pw,n);
        hold on;
        title(sprintf('Channel %d',n));
        plot(t,data2(n,:),'r');
    end
    prevSequence = thisFile.sequence;
    prevMax = newMax;
end
