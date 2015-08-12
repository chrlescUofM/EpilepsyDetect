%% A function that can be called in place of featureExtract to introduce randomness
% into the test set order for reduction of overfitting error.
%
% preictal - Contains the resulting pre-ictal training features.
% interitctal - Contains the resulting inter-ictal training features.
% test - Contains the resulting test set features.
% fileName - The filename of a single subject on disk.
function [preictal, interictal, test] = featureExtractValidate(fileName)

% Select file path based on operating system.
if(ispc)
    x = strcat('K:\eecs498\data\chrlesc\Subjects\',fileName,'\');
else
    x = strcat('/afs/umich.edu/class/eecs498/data/chrlesc/Subjects/',fileName,'/');
end

preictalClips = dir([x '*_preictal_*.mat']);
interictalClips = dir([x '*_interictal_*.mat']);

preictal = featureExtractHelper(preictalClips, x);
preictal = [ones(size(preictal,1),1) preictal];
interictal = featureExtractHelper(interictalClips, x);
interictal = [zeros(size(interictal,1),1) interictal];

% Randomly select preictal & interictal clips to use as test data.
rng(10); %seed the random number generator.
% Take 10 percent of the preictal and interictal data.
preSize = round(size(preictal,1)*0.10);
interSize = round(size(interictal,1)*0.10);
preIndexes = randsample(size(preictal,1),preSize);
interIndexes = randsample(size(interictal,1),interSize);

% Move the selected features into the test 
test = zeros(interSize+preSize, size(interictal,2));
test(1:preSize,:) = preictal(preIndexes,:);
preictal(preIndexes,:) = [];
test(preSize+1:end,:) = interictal(interIndexes,:);
interictal(interIndexes,:) = [];

end