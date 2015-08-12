# EpilepsyDetect
My work for the Kaggle Seizure Prediction challenge (https://www.kaggle.com/c/seizure-prediction).

## Repository Structure
EpilepsyDetect/ 		-- Containing directory.
	README.md   		-- This file.
	results.pdf 		-- A report containing an overview of the methods used and the results achieved.
	[basicFeatures/](/basicFeatures/)		-- Directory containing the code for calculating simple seizure features.
		crossValidation.m 		-- Computes cross validation on the results.
		featureExtract.m 		-- Computes the basic features given a single subject.
		featureExtractHelper.m  -- Computes the basic features given a single subject segment.
		featureExtractValidate.m-- A function to help reduce overfitting in featureExtract.
		localClassifier.m 		-- The entry point.  Run this to calcualte basic features.
		makePlot.m 				-- A function for visualizing the data.
	LaTeX/				-- Directory containing the report creation. (Sub-directories omitted)
	STLMax/				-- Directory containing the code for calculating STLMax values.
		lyapunov.m
		rosensteinLmax.m
		shortTimeLmax.m
		psr_deneme.m

---

<ul style="list-style: none;">
	<li>EpilepsyDetect/</li>
	<ul>
		<li>README.md</li>
		<li>results.pdf</li>
		<li>[basicFeatures/](/basicFeatures/)</li>
		<ul>
			<li>crossValidation.m</li>
			<li>featureExtract.m</li>
		</ul>
		<li>LaTeX/</li>
		<li>STLMax/</li>
	</ul>
</ul>

---

* EpilepsyDetect/
  * README.md   		
  * [results.pdf](/results.pdf) 		
  * [basicFeatures/](/basicFeatures/)		
    * crossValidation.m 		
	* featureExtract.m 		
	* featureExtractHelper.m  
	* featureExtractValidate.m
	* localClassifier.m
	* makePlot.m
  * LaTeX/
  * STLMax/
	* lyapunov.m
	* rosensteinLmax.m
	* shortTimeLmax.m
	* psr_deneme.m


