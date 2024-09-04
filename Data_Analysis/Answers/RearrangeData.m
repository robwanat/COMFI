%% Reorganize data to facilitate the calculation of anovan and F-tests

AnswerFiles = dir('../../Experiment_Data/Corrected*.csv');

CombinedData = zeros(6,11,37);
CombinedDataComplete = zeros(6,11,2,37);
for i = 1:length(AnswerFiles)
    CurrentData = readmatrix(['../../Experiment_Data/' AnswerFiles(i).name]);
    CurrentData = cat(3, CurrentData(:,1:11), CurrentData(:,12:end));
    CombinedDataComplete(:,:,:,i) = CurrentData;
    CombinedData(:,:,i) = mean(CurrentData,3);
end

CombinedDataComplete(CombinedDataComplete == 0) = NaN;
CombinedDataComplete(1:3, 10, :,:) = NaN;

RearrangedData = zeros(11 * 6 * 37 * 2, 5);
[Data1, Data2, Data3, Data4] = ndgrid(1:6, 1:11, 1:2, 1:37);
RearrangedData(:,1:4) = [Data1(:) Data2(:) Data3(:) Data4(:)];
RearrangedData(:,5) = CombinedDataComplete(sub2ind(size(CombinedDataComplete),RearrangedData(:,1), RearrangedData(:,2),RearrangedData(:,3),RearrangedData(:,4)));
RearrangedDataAveraged = [RearrangedData( RearrangedData(:,3) ==1, [1 2 4]) mean([RearrangedData(RearrangedData(:,3) == 1, 5), RearrangedData(RearrangedData(:,3) == 2,5)],2)];

% ObserverNames = AnswerFiles.name;
for i =1:37
    ObserverNames{i} = AnswerFiles(i).name(end-6:end-4);
end
Observers = ObserverNames(RearrangedData(:,4));
Displays = {'C2', 'X310', 'Projector', 'DELL'};
PossiblePairs = nchoosek(1:4,2);
for i = 1:6
    DisplayPairNames{i} = sprintf('%s-%s', Displays{PossiblePairs(i,1)}, Displays{PossiblePairs(i,2)});
end
DisplayList = DisplayPairNames(RearrangedData(:,1));
DataTable = table(DisplayList', RearrangedData(:,2),RearrangedData(:,3), Observers', RearrangedData(:,5), 'VariableNames',{'Display Pair', 'Color', 'Repetition',  'Observer','Score'});

