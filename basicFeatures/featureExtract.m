%% A function to extract features for training and test data given a single subject.
%
% preictal - Contains the resulting pre-ictal training features.
% interitctal - Contains the resulting inter-ictal training features.
% test - Contains the resulting test set features.
% fileName - The filename of a single subject on disk.
function [preictal, interictal, test] = featureExtract(fileName)
	
% Select file path based on operating system.
if(ispc)
    x = strcat('K:\eecs498\data\chrlesc\Subjects\',fileName,'\');
else
    x = strcat('/afs/umich.edu/class/eecs498/data/chrlesc/Subjects/',fileName,'/');
end

preictalClips = dir([x '*_preictal_*.mat']);
interictalClips = dir([x '*_interictal_*.mat']);
testClips = dir([x '*_test_*.mat']);

preictal = featureExtractHelper(preictalClips, x);
preictal = [ones(size(preictal,1),1) preictal];
interictal = featureExtractHelper(interictalClips, x);
interictal = [zeros(size(interictal,1),1) interictal];
test = featureExtractHelper(testClips, x);

end