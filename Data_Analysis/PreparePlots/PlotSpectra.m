%% Generate Figure 3
DisplayData(:,:,1) = csvread('../DisplayMeasurements/C2_Spectra.csv');
DisplayData(:,:,2) = csvread('../DisplayMeasurements/X310_Spectra.csv');
DisplayData(:,:,3) = csvread('../DisplayMeasurements/Projector_Spectra.csv');
DisplayData(:,:,4) = csvread('../DisplayMeasurements/VG246_Spectra.csv');

figure;
clf; hold on; grid on;
symbols = {'-', '--', '-.', ':'};
Colors = linspecer(4);

for i=1:4
    if i > 1
        plot(380:750, DisplayData(10,1:end-30,i)./max(DisplayData(10,1:end-30,i)),[symbols{i}], 'LineWidth',2 , 'Color', Colors(i,:));  
    else %D65 18 cd/m2 spectrum is wrong, use 2 cd/m2 spectrum but filter due to low luminance noise
        plot(380:750, medfilt2(DisplayData(11,1:end-30,i)./max(DisplayData(11,1:end-30,i)),[1 2]),[symbols{i}], 'LineWidth', 2, 'Color', Colors(i,:));
    end
end
xlim([400 750])
set(gca, 'LineWidth',2);
set(gca, 'FontSize', 16);
xlabel('Wavelength [nm]');
ylabel('Normalized Spectrum');
h = legend({'OLED TV', 'Reference Monitor', 'Laser Projector', 'Gaming Monitor'},'Location',"north")
h.Position = [0.322912505058012,0.698273535241669,0.286197921906908,0.225258180647832];
set(gcf,'Position', [866.6,585,767.9999999999999,465]);
exportgraphics(gcf,'display_spectra.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');