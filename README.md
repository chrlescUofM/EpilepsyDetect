# EpilepsyDetect
My work for the Kaggle Seizure Prediction challenge (https://www.kaggle.com/c/seizure-prediction).

## Repository Structure
EpilepsyDetect/ 		-- Containing directory.
	README.md   		-- This file.
	results.pdf 		-- A report containing an overview of the methods used and the results achieved.
	basicFeatures/		-- Directory containing the code for calculating simple seizure features.
		crossValidation.m 		-- Computes cross validation on the results.
		featureExtract.m 		-- Computes the basic features given a single subject.
		featureExtractHelper.m  -- Computes the basic features given a single subject segment.
		featureExtractValidate.m-- A function to help reduce overfitting in featureExtract.
		localClassifier.m 		-- The entry point.  Run this to calcualte basic features.
		makePlot.m 				-- A function for visualizing the data.
	LaTeX/				-- Directory containing the report creation.
	STLMax/				-- Directory containing the code for calculating STLMax values.


