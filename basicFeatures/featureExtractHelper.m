%% A function to compute the basic features given a subject segment.
% 
% results - Holds the basic features, variance and maximal cross correlation.
% clips - A listing of the different subject segements to load.
% x - The file path to load subject data from.
function result = featureExtractHelper(clips, x)
    
    % Load the first file so that we can get some sizes
    % and names to pre-allocate for speed.
    file = load([x clips(1).name]);
    names = fieldnames(file);
    thisFile = file.(names{1});
    data = thisFile.data;

    % n channels in the data.
    n = size(data,1);
    result = zeros(size(clips,1), n + n*n);

    parfor i = 1:size(clips,1)
        % Load the file from disk.
        file = load([x clips(i).name]);
        names = fieldnames(file);
        thisFile = file.(names{1});

        % Compute the inner channel variance.
        channelVariance = var(thisFile.data');

        % Compute the Maximal-Cross Correlation
        % F. Mormann "On the predictability of epileptic seizures"
        % Use the .5 * sampling frequency as offset limit, +/- 0.5 sec.
        lag = round(round(thisFile.sampling_frequency) * 0.5);
        [crossCorr, ~] = xcorr(thisFile.data',lag,'coeff');
        [~,I] = max(abs(crossCorr));

        % Concatenate Feature vector:
        result(i,:) = [channelVariance diag(crossCorr(I,1:length(I)))'];
    end
    display('Finished set of clips!');
end