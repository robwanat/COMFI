%% Plots the histograms of averaged observer answers for each display pair 
% and color
AnswerFiles = dir('../../Experiment_Data/Corrected*.csv');
Displays = {'OLED', 'RM', 'LP', 'GM'};
DisplayPairs = nchoosek(1:4,2);

CombinedData = zeros(6,11,37);
for i = 1:length(AnswerFiles)
    CurrentData = readmatrix(['../../Experiment_Data/' AnswerFiles(i).name]);
    CurrentData = cat(3, CurrentData(:,1:11), CurrentData(:,12:end));
    CombinedData(:,:,i) = mean(CurrentData,3);
end
CombinedData(CombinedData == 0) = NaN;
CombinedDataInverted = 5 - CombinedData;
figure(1);  clf;hold on;
% title('Experiment observer answer histograms (LP - Laser Projector, RM - Reference Monitor, GM - Gaming Monitor)')

for i=1:11

    for j =1 : 6

        if (ismember(i,[2 5]) && ismember(j, [3 5 6])) || (i==10 && ismember(j, 1:3))
            continue
        end
        subplot(6,11,(j-1) * 11 + i);
        histogram(reshape(CombinedDataInverted(j,i,:), [37 1]), 0:0.5:4);
        ylim([0 20]);
        grid on;
        if i == 1
            ylabel(sprintf('%s -\n%s\nHistogram',Displays{DisplayPairs(j,1)},Displays{DisplayPairs(j,2)}));
        end
        set(gca,'FontSize', 10);
        if j == 1
            title(sprintf('Color %d',i));
        end
        if j == 6 && i == 6
            xlabel('Observer score bins (LP - Laser Projector, RM - Reference Monitor, GM - Gaming Monitor)')
        end
    end
end