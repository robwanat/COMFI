%% Generate Figure 6 in the paper
clear all;
close all

filename_of_generated_observer_cmfs = "../GeneratedCMFs.mat";
load(filename_of_generated_observer_cmfs)

filename_of_xyz_1931_cmf = "ciexyz31_1.csv";
xyz_1931_cmf = csvread(filename_of_xyz_1931_cmf);

[number_of_cmf_bins, number_of_cmf_channels, number_of_observers] = size( Individual_CMFs );

cmf_channel_labels{1} = 'X';
cmf_channel_labels{2} = 'Y';
cmf_channel_labels{3} = 'Z';

%wavelength sampling from 390nm to 780nm at 5nm interval
wavelength_nm_start = 390;
wavelength_nm_end = 780;
wavelength_nm_interval = 5;
wavelengths_nm = wavelength_nm_start : wavelength_nm_interval : wavelength_nm_end;

figure;
for i = 1:round(number_of_observers/1)

    observer_spectra_XYZ = Individual_CMFs(:,:,i);

    for c = 1:number_of_cmf_channels

        subplot( 3, 1, c);
        plot( wavelengths_nm + wavelength_nm_interval*(i-1)/(number_of_observers-1) - (wavelength_nm_interval/2) , observer_spectra_XYZ(:,c), 'LineWidth', 1);
        
        hold on;

        % to make empty legend entries so we can use legend for 1931 CMF
        legend_labels{c,i} = '';

    end

end

% add plot labels and xyz 1931 CMF
for c = 1:number_of_cmf_channels
    subplot( 3, 1, c);
    ylim([0 2.1])
    k = title( sprintf('%s Color Channel', cmf_channel_labels{c} ) );
    k.FontWeight = "normal";
    plot( xyz_1931_cmf(:,1),xyz_1931_cmf(:,1+c),'K:','Linewidth', 4 );
    if c >2
    xlabel( 'Wavelength [nm]' );
    end
    if c ==2
    ylabel( 'CMF Sensitivity');
    end
    grid on;
    grid minor;
    legend( legend_labels{c,:}, sprintf("CIE 1931 2^{\\circ}\nStandard Observer"), 'Location', 'NorthEast');
    set(gca, 'FontSize', 16);
end

set(gcf, "Position", [565.0000  436.2000  739.0000  613.8000]);

exportgraphics(gcf,'CMFs.eps',...   % since R2020a
'ContentType','vector',...
'BackgroundColor','none');
