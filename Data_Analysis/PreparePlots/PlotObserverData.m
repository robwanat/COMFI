%% Generate Figure 1 from the Supplementary Material
load("../Answers/ObserverData.mat");
figure; clf;
set(gcf, "Position", [589,527.4,715,522.6]);
ha = tight_subplot(1,2,[.01 .03],[.1 .01],[.01 .01]);
axes(ha(1));
h = pie(BirthSexCounts);
set(gca, "FontSize", 16);
legend(BirthSex,'Location','southoutside','Orientation','horizontal')
title("Sex");
set(findobj(h,'type','Text'),'FontWeight','bold');
k = findobj(h,'type','Text');
for i=1:length(k)
    set(k(i),'FontSize',14);
end
% set(findobj(h,'type','Text'),'Size',22);

axes(ha(2));

for i =1:5
    text = sprintf("%d-%d", AgeRanges(i,1), AgeRanges(i,2));
    AgeRangesText{i} = text;
end
h = pie(AgeCounts);
set(ha(2), "FontSize", 16);
h2 = legend(AgeRangesText,'Location','southoutside','Orientation','horizontal', 'FontSize', 16)
title("Age range")
set(findobj(h,'type','Text'),'FontWeight','bold');
k = findobj(h,'type','Text');
for i=1:length(k)
    set(k(i),'FontSize',14);
end
h2.Position = [0.250839865077617,0.071239100073469,0.742449673630247,0.058192956794458];
exportgraphics(gcf,'Observers.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');

