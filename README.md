# EpilepsyDetect
My work for the Kaggle Seizure Prediction challenge, for more information please see the challenge description [here](https://www.kaggle.com/c/seizure-prediction).

The dataset for this project is not included with the repository as it is quite large (~100gb), however it can be found at the aformentioned link.  The scripts must be edited in accordance with where you place the dataset on your machine.

## Repository Structure
* EpilepsyDetect/ -- Containing directory.
  * README.md -- This file.
  * [results.pdf](/results.pdf) -- A report containing an overview of the methods used and the results achieved.	
  * [basicFeatures/](/basicFeatures/) -- Directory containing the code for calculating simple seizure features.
    * [crossValidation.m](/basicFeatures/crossValidation.m) -- Computes cross validation on the results.	
	* [featureExtract.m](/basicFeatures/featureExtract.m) -- Computes the basic features given a single subject.
	* [featureExtractHelper.m](/basicFeatures/featureExtractHelper.m) -- Computes the basic features given a single subject segment.
	* [featureExtractValidate.m](/basicFeatures/featureExtractValidate.m) -- A function to help reduce overfitting in featureExtract.
	* [localClassifier.m](/basicFeatures/localClassifier.m) -- The entry point.  Run this to calcualte basic features.
	* [makePlot.m](/basicFeatures/makePlot.m) -- A function for visualizing the data.
  * [LaTeX/](/LaTeX/) -- Directory containing the report creation. (Sub-directories omitted)
  * [STLMax/](/STLMax/) -- Directory containing the code for calculating STLMax values.
	* [lyapunov.m](/STLMax/lyapunov.m) -- Calculate single LMax values using the originla formulation (slow, may not converge)
	* [rosensteinLmax.m](/STLMax/rosensteinLmax.m) -- Calculate single LMax values using rosenstein formulation.
	* [shortTimeLmax.m](/STLMax/shortTimeLmax.m) -- The entry point.  Run this to calculate STLMax values.
	* [psr_deneme.m](/STLMax/psr_deneme.m) -- Compute the phase space reconstruction.  Used by rosensteinLmax.


