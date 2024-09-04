%% Generates Figure 1
clear all;
caxis_range = [0.2 0.5];
figure(1); clf; 
ha = tight_subplot(1,3,[.0 .005],[.1 .0],[.1 .1]);
%% Plot xy chromaticity gamut with OMI map
axes(ha(1)); hold on;
plotGamut(1,0);
data = load("../OMFI/VG246_POMIMap.mat");
tri = delaunay(data.PointsDistributionxy(1, :), data.PointsDistributionxy(2,:));
patch('faces', tri, 'vertices', data.PointsDistributionxy', 'FaceVertexCData', data.POMI','FaceColor','interp', 'EdgeAlpha', 0.0, 'LineWidth', 0.1);
plot(0.3127, 0.329, 'ow');
clim(caxis_range); 
h1 = ylabel('CIE y');
set(gca, 'FontSize', 8);
colormap(linspecer);
k(:,:) = [0.6415	0.335;
0.3163	0.6254;
0.1496	0.0514
];
plot(k([1:end 1],1), k([1:end 1],2),'--k', 'LineWidth', 1.5);
yticks([0:0.3:0.8]);
yticklabels([0:0.3:0.8]);
xticks(0:0.3:0.6);
xticklabels(0:0.3:0.6);
text(0.51, 0.55, sprintf('Gaming\nMonitor'), FontSize=8,FontWeight="normal");


%% Second plot
%% Plot xy chromaticity gamut with OMI map
axes(ha(2)); hold on;
plotGamut(1,0);
data = load("../OMFI/X310_POMIMap.mat");
tri = delaunay(data.PointsDistributionxy(1, :), data.PointsDistributionxy(2,:));
patch('faces', tri, 'vertices', data.PointsDistributionxy', 'FaceVertexCData', data.POMI','FaceColor','interp', 'EdgeAlpha', 0.0, 'LineWidth', 0.1);
plot(0.3127, 0.329, 'ow');
clim(caxis_range); 
h2 = xlabel('CIE x');
set(gca, 'FontSize', 8);
k(:,:) = [0.6876	0.3099;
0.2196	0.7189;
0.1459	0.0541
];
handle_gamut = plot(k([1:end 1],1), k([1:end 1],2), '--k', 'LineWidth', 1.5);
handle_legend = legend(handle_gamut, sprintf('Display\nGamut'),Location='northeast');
xticks(0:0.3:0.6);
xticklabels(0:0.3:0.6);
text(0.51, 0.55, sprintf('Reference\nMonitor'), FontSize=8,FontWeight="normal");

%% Plot 3
%% Plot xy chromaticity gamut with OMI map
axes(ha(3)); hold on;
plotGamut(1,0);
data = load("../OMFI/Projector_POMIMap.mat");
tri = delaunay(data.PointsDistributionxy(1, :), data.PointsDistributionxy(2,:));
patch('faces', tri, 'vertices', data.PointsDistributionxy', 'FaceVertexCData', data.POMI','FaceColor','interp', 'EdgeAlpha', 0.0, 'LineWidth', 0.1);
plot(0.3127, 0.329, 'ow');
clim(caxis_range); 
OriginalSize = get(gca, "Position");
k(:,:) = [0.7174	0.2808;
0.1077	0.8177;
0.1405	0.0374
];
plot(k([1:end 1],1), k([1:end 1],2), '--k', 'LineWidth', 1.5);
text(0.51, 0.55,sprintf('Laser\nProjector'), FontSize=8,FontWeight="normal");
colorbar;
xticks(0:0.3:0.6);
xticklabels(0:0.3:0.6);
set(gca, 'FontSize', 8);
set(gca, "Position", OriginalSize);
set(gcf, "Position", [729,791.4,575,258.6]);
h1.Position = [-0.073743388892482,0.425000417232525,-1];
h2.Position = [0.367063849691361,-0.055555558015429,-1];
handle_legend.Position = [0.482646107738908,0.754116753421148,0.144297636931397,0.114551085953373];
exportgraphics(gcf,'POMI_Maps.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');