%% Generate Figure 7

load('../DisplayMeasurements/X310_Spectra.mat');

%% Precomputed primaries for faster calculation
k(:,:,3) = [0.7174	0.2808;
0.1077	0.8177;
0.1405	0.0374
];

k(:,:,4) = [0.6415	0.335;
0.3163	0.6254;
0.1496	0.0514
];

k(:,:,2) = [0.6876	0.3099;
0.2196	0.7189;
0.1459	0.0541
];

k(:,:,1) = [0.681	0.3179;
0.2651	0.6829;
0.1475	0.0528
];

figure; clf; hold on;
plotGamut();
hold on;
for i = 1:4
    handles(i) = plot(k([1:end 1],1,i), k([1:end 1],2,i), 'LineWidth', 2.5);
end



legend(handles,{'OLED TV', 'Reference Monitor', 'Laser Projector', 'Gaming Monitor'})

for i=1 :10
    if i < 10
    XYZ = spd2xyz(X310_Spectra(i,:), 380:780);
    xyz = XYZ./sum(XYZ);
    else
        xyz = [0.3127 0.329];
    end
    text_shift = [0.01 0.03];
    if i == 8 || i == 10
        text_shift(1) = 0.02;
    end
    h = plot(xyz(1), xyz(2), 'xk', 'MarkerSize', 10, 'LineWidth', 3, 'HandleVisibility','off');
    text(xyz(1)-text_shift(1), xyz(2)+text_shift(2), sprintf('%d',i), "FontSize",14, "FontWeight",'bold');
end
xlabel('CIE x');
ylabel('CIE y');
set(gca, "LineWidth",2);
set(gca, "FontSize",14);
set(gcf, "Position", [422.6,505.8,881.4,544.2]);
exportgraphics(gcf,'DisplayGamuts.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');