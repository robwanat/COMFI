%% Generate Figure 4
AnswerData = load('../Answers/AnswerData.mat');
load('../DisplayMeasurements/X310_Spectra.mat');
RGBs = zeros(11,3);
for i=1:11
    if i < 10
        XYZ = spd2xyz(X310_Spectra(i,:), 380:780);
        RGBs(i,:) = xyz2rgb(XYZ,"ColorSpace","adobe-rgb-1998");
        RGBs(i,:) = (RGBs(i,:)./max(RGBs(i,:))).^2;
    elseif i < 11
        RGBs(i,:) = [1 1 1];
    else
        RGBs(i,:) = [0.5 0.5 0.5];
    end
end


figure(1); clf; hold on;
Markers = ['o+*x^v'];
AnswerData.PopulationAverageMean(1:3, 10) = NaN;
AnswerData.PopulationAverageStdDev(1:3, 10) = NaN;
Smax = sqrt((-((AnswerData.PopulationAverageMedian/4).^2) + (AnswerData.PopulationAverageMedian/4)));
AnswerData.PopulationAverageVarianceAdjusted = (AnswerData.PopulationAverageStdDev).*Smax;
addedValue = linspace(-0.35,0.35,6);
colors = linspecer(6,'qualitative');
for i = 1:11
    for j =1:6
        STDMedian = AnswerData.PopulationAverageVarianceAdjusted(j,i);
        ErrorNeg = STDMedian - AnswerData.LowerSTDError(j,i).*Smax(j,i);
        ErrorPos =  AnswerData.UpperSTDError(j,i).*Smax(j,i) - STDMedian;
        errorbar(STDMedian,i + addedValue(j),ErrorNeg,ErrorPos, 'horizontal', Markers(j), 'Color', colors(j,:), LineWidth=2);
    end
    if i < 11
        plot([0.1 0.63], [i + 0.5 i+0.5], '--k');
    end
    patch([0.575 0.63 0.63 0.575], [i - 0.2 i-0.2 i+0.2 i+0.2], RGBs(i,:));
    plot([0.575 0.63 0.63 0.575], [i - 0.2 i-0.2 i+0.2 i+0.2], '-k');
end
ylim([0.5 11.5]);
h1 = xlabel('\sigma_{adj}');
h2 = ylabel('Color');
h1.Position = [0.350000251084577,0.28268677181211,-1];
h2.Position = [0.078,6,-1];
set(gca, 'FontSize', 10);
set(gcf, "Position",[857,321.8,447,728.2]);
Displays = {'OLED TV', 'Reference Monitor', 'Laser Projector', 'Gaming Monitor'};
Combos = nchoosek(1:4,2);
xlim([0.1 0.635]);
for i = 1 :6
DisplayPair{i} = sprintf('%s - %s',Displays{Combos(i,1)},Displays{Combos(i,2)});
end
legend(DisplayPair, "Location", 'northoutside')
 exportgraphics(gcf,'Results_Raw.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');