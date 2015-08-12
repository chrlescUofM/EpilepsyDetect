%% A function for computing crossValidation between the training and testing data.
% D - Matrix containing the probabilities for each iteration of the cross validation.
%   This can then be further processed to get numbers of interest.
% preictalTrain - The preictal training data for a single subject.
% interictalTrain - The interictal training data for a single subject.
% testIn - the test data for a single subject.
function D = crossValidation(preictalTrain, interictalTrain, testIn)
preictal = [preictalTrain; testIn(1:2,:)];
interictal = [interictalTrain; testIn(3:end,:)];

% seed the random number generator.
rng(10);
% take 10 percent of the preictal and interictal data.
preSize = round(size(preictal,1)*0.10);
interSize = round(size(interictal,1)*0.10);
iter = 20;
% Pre-alocate D for speed.
D = zeros((preSize+interSize)*iter,2);
for i = 1:iter
    % Grab the relevant portion.
    preictal = [preictalTrain; testIn(1:2,:)];
    interictal = [interictalTrain; testIn(3:end,:)];
    preIndexes = randsample(size(preictal,1),preSize);
    interIndexes = randsample(size(interictal,1),interSize);
    % Move the selected features into the test 
    test = zeros(interSize+preSize, size(interictal,2));
    test(1:preSize,:) = preictal(preIndexes,:);
    preictal(preIndexes,:) = [];
    test(preSize+1:end,:) = interictal(interIndexes,:);
    interictal(interIndexes,:) = [];
    
    % Concatenate training data.
    train = vertcat(preictal, interictal);

    % Train the SVM models.
    svm = fitcsvm(train(:,2:size(train,2)),train(:,1));

    % Fit the model to estimate posterior probabilities rather than weights.
    svmProb = fitPosterior(svm, train(:,2:size(train,2)),train(:,1));

    % Use the model to predict classification for the testing data.
    [~, pred] = predict(svmProb, test(:,2:end));

    % Take just the second column, which contains our prob. of interest.
    pred = pred(:,2);
    pred(:,2) = test(:,1);
    D((preSize+interSize)*(i-1)+1:(preSize+interSize)*(i),:) = pred;
end

