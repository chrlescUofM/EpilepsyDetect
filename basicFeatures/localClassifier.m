%% Top Level Function for the Kaggle American Epilepsy Society Seizure Prediction Challenge
%% Unfortunately verbose due to limitation of matlab to pass 2D matrix as function output into
%% a three dimensional matrix.

% A list of the different test subjects.
fileName = {'Dog_1','Dog_2','Dog_3','Dog_4','Dog_5','Patient_1','Patient_2'};

% Extract features for each of the subjects independently.
[preictalTrainD1,interictalTrainD1, testD1] = featureExtract(fileName{1});
[preictalTrainD2,interictalTrainD2, testD2] = featureExtract(fileName{2});
[preictalTrainD3,interictalTrainD3, testD3] = featureExtract(fileName{3});
[preictalTrainD4,interictalTrainD4, testD4] = featureExtract(fileName{4});
[preictalTrainD5,interictalTrainD5, testD5] = featureExtract(fileName{5});
[preictalTrainH1,interictalTrainH1, testH1] = featureExtract(fileName{6});
[preictalTrainH2,interictalTrainH2, testH2] = featureExtract(fileName{7});

%Concatenate training data.
trainD1 = vertcat(preictalTrainD1, interictalTrainD1);
trainD2 = vertcat(preictalTrainD2, interictalTrainD2);
trainD3 = vertcat(preictalTrainD3, interictalTrainD3);
trainD4 = vertcat(preictalTrainD4, interictalTrainD4);
trainD5 = vertcat(preictalTrainD5, interictalTrainD5);
trainH1 = vertcat(preictalTrainH1, interictalTrainH1);
trainH2 = vertcat(preictalTrainH2, interictalTrainH2);

% Train the SVM models.
svmD1 = fitcsvm(trainD1(:,2:size(trainD1,2)),trainD1(:,1));
svmD2 = fitcsvm(trainD2(:,2:size(trainD2,2)),trainD2(:,1));
svmD3 = fitcsvm(trainD3(:,2:size(trainD3,2)),trainD3(:,1));
svmD4 = fitcsvm(trainD4(:,2:size(trainD4,2)),trainD4(:,1));
svmD5 = fitcsvm(trainD5(:,2:size(trainD5,2)),trainD5(:,1));
svmH1 = fitcsvm(trainH1(:,2:size(trainH1,2)),trainH1(:,1));
svmH2 = fitcsvm(trainH2(:,2:size(trainH2,2)),trainH2(:,1));

% Fit the model to estimate posterior probabilities rather than weights.
svmProbD1 = fitPosterior(svmD1, trainD1(:,2:size(trainD1,2)),trainD1(:,1));
svmProbD2 = fitPosterior(svmD2, trainD2(:,2:size(trainD2,2)),trainD2(:,1));
svmProbD3 = fitPosterior(svmD3, trainD3(:,2:size(trainD3,2)),trainD3(:,1));
svmProbD4 = fitPosterior(svmD4, trainD4(:,2:size(trainD4,2)),trainD4(:,1));
svmProbD5 = fitPosterior(svmD5, trainD5(:,2:size(trainD5,2)),trainD5(:,1));
svmProbH1 = fitPosterior(svmH1, trainH1(:,2:size(trainH1,2)),trainH1(:,1));
svmProbH2 = fitPosterior(svmH2, trainH2(:,2:size(trainH2,2)),trainH2(:,1));

% Use the model to predict classification for the training data.
[~, D1pred] = predict(svmProbD1, testD1);
[~, D2pred] = predict(svmProbD2, testD2);
[~, D3pred] = predict(svmProbD3, testD3);
[~, D4pred] = predict(svmProbD4, testD4);
[~, D5pred] = predict(svmProbD5, testD5);
[~, H1pred] = predict(svmProbH1, testH1);
[~, H2pred] = predict(svmProbH2, testH2);

% Take just the second column, which contains our prob. of interest.
D1pred = D1pred(:,2);
D2pred = D2pred(:,2);
D3pred = D3pred(:,2);
D4pred = D4pred(:,2);
D5pred = D5pred(:,2);
H1pred = H1pred(:,2);
H2pred = H2pred(:,2);

% Write the predictions to file
% Now concatenate and save these predictions to file
Predictions = vertcat(D1Pred, D2Pred, D3Pred, D4Pred, D5Pred, H1Pred, H2Pred);
Predictions = array2table(Predictions);
SampleSub = readtable('sampleSubmission.csv');
SampleSub(:,2) = Predictions;
writetable(SampleSub, 'BenchmarkSubmission.csv');
