function POMI_Result = CalcOMFI_DEITP(Spectrum1, wavelengths1, Spectrum2, wavelengths2)
%% Calculate the DEITP values between two compared spectra for each of the individual CMFs
% Spectrum-wavelengths pairs describe each spectral radiance
persistent CMFs;
if isempty(CMFs)
    CMFs = getfield(load('../GeneratedCMFs.mat'),'Individual_CMFs');
end
SPDWavelengths = 390:5:780;
DEITPs = zeros(size(CMFs,3),1);
for i = 1:size(CMFs,3)
        CurrentCMF = CMFs(:,:,i)';
        XYZ1 = spd2xyz(Spectrum1,wavelengths1, CurrentCMF, SPDWavelengths);
        XYZ2 = spd2xyz(Spectrum2,wavelengths2, CurrentCMF, SPDWavelengths);
        ITP1 = XYZ2ICtCp(XYZ1);
        ITP2 = XYZ2ICtCp(XYZ2);
        %inline DEITP formula for speed
        DEITPs(i) = 720 * norm(ITP1.*[1 0.5 1] - ITP2 .*[1 0.5 1]);
end
POMI_Result = DEITPs;