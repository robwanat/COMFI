%% Plot of Krippendroff's alpha values for each observer as well as the cutoff value

AnswerFiles = dir('../../Experiment_Data/Corrected*.csv');

CombinedData = zeros(6,11,37);
CombinedDataComplete = zeros(6,11,2,37);
AssessmentDifference = zeros(1,37);
for i = 1:length(AnswerFiles)
    CurrentData = readmatrix(['../../Experiment_Data/' AnswerFiles(i).name]);
    ObserverNames{i} = AnswerFiles(i).name(end-6:end-4);
    CurrentData = cat(3, CurrentData(:,1:11), CurrentData(:,12:end));
    CombinedDataComplete(:,:,:,i) = CurrentData;
end

CombinedDataComplete(CombinedDataComplete == 0) = NaN;

for i = 1:37
    ObserverKrippAlpha(i) = kriAlpha([reshape(CombinedDataComplete(:,:,1,i),1,[])' reshape(CombinedDataComplete(:,:,2,i),1,[])']', 'interval');
end
plot(ObserverKrippAlpha, 'vk'); hold on;
set(gca,'FontSize', 16);
set(gca,'XTick', 1:37);
set(gca, 'XTickLabels', ObserverNames);
xlim([0.5 37.5]);
plot([0.5 37.5], [0.5 0.5], '--r');
grid on
xlabel('Observer');
ylabel('Krippendorff''s \alpha');
title('Observer Answer Consistency')
% set(gcf,'Position', [370.3333333333333,918,1381.333333333333,420]);