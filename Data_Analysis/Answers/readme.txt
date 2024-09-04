This folder contains the code for the analysis of the experimental data. To
generate the plots from the paper, LoadAnswers.m function must be run at
least once to pre-generate the AnswerData.mat file used for plotting. 

Some additional data visualization is included:
- CheckObserverConsistency plots individual Krippendorff's alpha values
- PlotAnswerHistograms plots the histogram of averaged observer answers
- RearrangeData redistributes the data into a single 4884x5 table 
containing all the fields, making it easier to statistically analyze the 
data

ObserverData.mat contains the data about the experiment participants and
contains fields:
- AgeRanges - a 5x2 matrix where the first column contains the lower limits
and the second column contains the upper limits of the age ranges used in 
the pre-experiment survey
- AgeCounts - a 1x5 array containing the total counts of observers who
chose the respective age range in the survey
- BirthSex - a 1x2 cell array containing the options of birth sex in the
survey
- BirthSexCounts - a 1x2 array containing the total counts of observers
who chose the respective birth sex in the survey