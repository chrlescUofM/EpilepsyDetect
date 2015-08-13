%% A script for calculating STLmax values.
clear all; close all;
% A list of the subject names.
fileName = {'Dog_1','Dog_2','Dog_3','Dog_4','Dog_5','Patient_1','Patient_2'};
% Select file path based on operating system.
if(ispc)
    x = strcat('K:\eecs498\data\chrlesc\Subjects\',fileName{1},'\');
else
    x = strcat('/afs/umich.edu/class/eecs498/data/chrlesc/Subjects/',fileName{1},'/');
end

% Get a list of all of the files we will need to read in.
preictalClips = dir([x '*_preictal_*.mat']);
interictalClips = dir([x '*_interictal_*.mat']);
testClips = dir([x '*_test_*.mat']);

% Read in the first one so that we can pre-allocate for speed.
file = load([x preictalClips(1).name]);
names = fieldnames(file);
thisFile = file.(names{1});
data = thisFile.data;
jmax = 6;
k = 16;
delayBins = round(round(thisFile.sampling_frequency) * 10);
stlMax = zeros(1,floor(size(data,2)/delayBins)*jmax);

for j = 1:jmax
    j
    % Load a single clip.
    file = load([x preictalClips(j).name]);
    names = fieldnames(file);
    thisFile = file.(names{1});
    data = thisFile.data;
    for i = 1:floor(size(data,2)/delayBins)
        i
        % Take only a portion of the data for analysis.
        segment = data(:,(delayBins*(i-1)+1):(delayBins*i));

        % Alternative formulation of the maximum lyapunov exponent, slow and may not converge appropriately.
        %stlMax6(((j-1)*floor(size(data,2)/delayBins))+i) = lyapunov(segment(k,:)',(1/thisFile.sampling_frequency));

        % Calculate the STLMax value using the rosenstein formulation.
        stlMax(((j-1)*floor(size(data,2)/delayBins))+i) = rosensteinLmax(segment(k,:),7,4,50,round(thisFile.sampling_frequency));
    end
end
% Save the result to disk.
save('stlMax.mat','stlMax');
