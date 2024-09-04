%% Generate Figure 5 and Figure 8 in the paper
AnswerData = load('../Answers/AnswerData.mat');
OMFIData = load('../OMFI/OMFIData.mat');
% remove D65 white on OLED because of calibration issues
AnswerData.PopulationAverageStdDev(1:3, 10) = NaN;
Smax = sqrt((-((AnswerData.PopulationAverageMedian/4).^2) + (AnswerData.PopulationAverageMedian/4)));
AnswerData.PopulationAverageVarianceAdjusted = (AnswerData.PopulationAverageStdDev).*Smax;
Data1 =  (AnswerData.PopulationAverageVarianceAdjusted(~isnan(AnswerData.PopulationAverageStdDev)));
OMFIData.OMFI_DEITP_STD = std(OMFIData.OMFI_DEITP,0,3, "omitnan");
Data2 = OMFIData.OMFI_DEITP_STD(~isnan(AnswerData.PopulationAverageStdDev));

OMFI_DE2000_ModSTD = squeeze(std(OMFIData.OMFI_DE2000_Modded,0,1, "omitnan"));
Correlations_Pearson = zeros(3,10);
Correlations_Spearman = zeros(3,10);
for i = 1:10
    for j =1 :3
        DataValues = squeeze(OMFI_DE2000_ModSTD(j,i,:,:));
        DataValues(1:3,10) = 0;
        DataValues(DataValues == 0) = NaN;
        correlationcoef = corr(Data1, DataValues(~isnan(AnswerData.PopulationAverageStdDev)), 'type','Pearson');
        Correlations_Pearson(j,i) = correlationcoef;
        correlationcoef = corr(Data1, DataValues(~isnan(AnswerData.PopulationAverageStdDev)), 'type','Spearman');
        Correlations_Spearman(j,i) = correlationcoef;
    end
end

% the fitting function used does not allow for adding bias so the bias is
% added in the next line and subtracted in line 33
[Outputs, LogiParams, sm, varcov] = fit_logistic(Data2, Data1-0.2);
thalf = LogiParams(1);
Qinf = LogiParams(2);
alpha = LogiParams(3);
DataInput = 0:0.1:7;
Q = Qinf./(1 + exp(-alpha*((DataInput)-thalf))) + 0.2;

figure(1); clf; hold on;
Markers = ['o+*x^v'];
colors = linspecer(6,'qualitative');
Displays = {'OLED TV', 'Reference Monitor', 'Laser Projector', 'Gaming Monitor'};

Combos = nchoosek(1:4,2);
for i = 1 :6
DisplayPair{i} = sprintf('%s - %s',Displays{Combos(i,1)},Displays{Combos(i,2)});
h = scatter(OMFIData.OMFI_DEITP_STD(i,:), AnswerData.PopulationAverageVarianceAdjusted(i,:),100,colors(i,:),Markers(i));
h.LineWidth = 2;
temp = corr(Data1, Outputs+0.2);

end
set(gca, 'FontSize', 14);
plot(DataInput, Q, '.k');
[h, icons] = legend([DisplayPair {'Logistic Fit'}],'Location', 'SouthEast');
icons = icons.findobj('Type','patch');
for i =1:6
    icons(i).MarkerSize = 8;
    icons(i).LineWidth = 2;
end
xlabel('Standard Deviation of \Delta{}E_{ITP} (\sigma_{ITP})')
ylabel('\sigma_{adj}')

grid on;

set(gcf, "Position",[603.4,571.4,700.6,478.6]);
exportgraphics(gcf,'Results_DEITP.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');
figure(2); clf; hold on;
for i=1:3
    handles(i) = plot(linspace(0.2,2,10), Correlations_Pearson(i,:), 'LineWidth',3);
    k = plot(linspace(0.2,2,10), Correlations_Spearman(i,:), 'LineWidth',3, LineStyle='--');
    k.Color = handles(i).Color;
end
legend([handles k], {'$k_L$ - PLCC', '$k_C$ - PLCC', '$k_H$ - PLCC', 'SROCC'}, 'Location', 'South', Interpreter='latex');
set(gca, 'FontSize', 14);
% set(gca, 'FontWeight', 'bold');
grid on;
xlim([0.1 2.1]);
xlabel('\Delta{}E_{2000} Parameter Value');
ylabel('Correlation');
set(gcf, "Position",[603.4,571.4,700.6,478.6]);
exportgraphics(gcf,'Results_DE2000.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');