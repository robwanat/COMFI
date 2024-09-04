%% A function to pre-process the experimental data and precompute the means 
%  and standard deviations of observer answers
rng(0);
AnswerFiles = dir('../../Experiment_Data/Corrected*.csv');

CombinedData = zeros(6,11,37);
CombinedDataComplete = zeros(6,11,2,37);
for i = 1:length(AnswerFiles)
    CurrentData = readmatrix(['../../Experiment_Data/' AnswerFiles(i).name]);
    CurrentData = cat(3, CurrentData(:,1:11), CurrentData(:,12:end));
    CombinedDataComplete(:,:,:,i) = CurrentData;
    CombinedData(:,:,i) = mean(CurrentData,3);
end
CombinedData(CombinedData == 0) = NaN;
CombinedDataComplete(CombinedDataComplete == 0) = NaN;

% Flip the answers so that best match (5) to worst match (1) becomes 
% no distortion (0) to most distortion (4)
CombinedDataInverted = 5 - CombinedData;

ReshapedData = reshape(CombinedDataInverted, [66 i]);

% Calculate Krippendorff's alpha, remove observers with alpha less than 0.5
ObserverKrippAlpha = zeros(1,37);
for i = 1:37
    ObserverKrippAlpha(i) = kriAlpha([reshape(CombinedDataComplete(:,:,1,i),1,[])' reshape(CombinedDataComplete(:,:,2,i),1,[])']', 'interval');
end
ExcludedObservers = find(ObserverKrippAlpha < 0.5);
FinalObserverList = 1:37;
FinalObserverList(ExcludedObservers) = [];
NrObserversFinal = length(FinalObserverList);

% Bootstrap a population of 10000 tests with n observers drawn with
% replacements from the original population to improve standard deviation
% accuracy
NrTests = 10000;
BootstrappedStdDev = zeros(66,NrTests);
BootstrappedMedian = zeros(66,NrTests);

for i = 1:NrTests
    ChosenObservers = FinalObserverList(ceil(rand([1 NrObserversFinal])*(NrObserversFinal)));
    CurrentTest = ReshapedData(:,ChosenObservers);
    BootstrappedStdDev(:,i) = std(CurrentTest,0,2,'omitnan');
    BootstrappedMedian(:,i) = median(CurrentTest, 2,'omitnan');
end

% calculate the mean value of both statistics across the 10000 populations
LowerSTDError = reshape(prctile(BootstrappedStdDev,2.5,2),[6 11]);
UpperSTDError = reshape(prctile(BootstrappedStdDev,97.5,2),[6 11]);
PopulationAverageStdDev = reshape(mean(BootstrappedStdDev,2,'omitnan'),[6 11]);
PopulationAverageMedian = reshape(mean(BootstrappedMedian,2, 'omitnan'),[6 11]); 

save AnswerData.mat CombinedData PopulationAverageMedian PopulationAverageStdDev  LowerSTDError UpperSTDError;
clear Bootstrapped*;