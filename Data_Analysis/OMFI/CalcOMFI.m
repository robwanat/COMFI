OMFI_DEITP = zeros(6,11,518);
OMFI_DE2000 = zeros(6,11,518);

load('../DisplayMeasurements/C2_Spectra.mat');
load('../DisplayMeasurements/X310_Spectra.mat');
load('../DisplayMeasurements/Projector_Spectra.mat');
load('../DisplayMeasurements/VG246_Spectra.mat');

CombinedSpectra = cat(3, C2_Spectra, X310_Spectra, Projector_Spectra, VG246_Spectra);

DisplayCombos = nchoosek(1:4,2);
ErrorGeneral = zeros(6, 11);
OMFI_DE2000_Modded = zeros(518,3,10,6,11);

for i = 1:11
    for j = 1:6
        if any(ismember(j, [3 5 6])) && (i == 2 || i == 5)
            OMFI_DEITP(j,i) = NaN;
            OMFI_DE2000(j,i) = NaN;
            ErrorGeneral(j,i) = NaN;
        else
            Displays = DisplayCombos(j,:);
            OMFI_DEITP(j,i,:) = CalcOMFI_DEITP(CombinedSpectra(i,:,Displays(1)), 380:780, CombinedSpectra(i,:,Displays(2)), 380:780);
            OMFI_DE2000(j,i,:) = CalcOMFI_DE2000(CombinedSpectra(i,:,Displays(1)), 380:780, CombinedSpectra(i,:,Displays(2)), 380:780);
            OMFI_DE2000_Modded(:,:,:,j,i) = CalcOMFI_DE2000_ModParams(CombinedSpectra(i,:,Displays(1)), 380:780, CombinedSpectra(i,:,Displays(2)), 380:780);
            XYZ1 = spd2xyz(CombinedSpectra(i,:,Displays(1)),380:780);
            XYZ2 = spd2xyz(CombinedSpectra(i,:,Displays(2)),380:780);
            ITP1 = XYZ2ICtCp(XYZ1);
            ITP2 = XYZ2ICtCp(XYZ2);
            ErrorGeneral(j,i) = 720 * norm((ITP1- ITP2).*[1 0.5 1]);
        end
    end
end
save OMFIData.mat OMFI_DE2000 OMFI_DEITP ErrorGeneral OMFI_DE2000_Modded;