function COMFI_Output = COMFI(Spectrum1, wavelengths1, Spectrum2, wavelengths2)
%COMFI A function to calculate COMFI (Calibrated Observer Metameric Failure
% Index). Takes two spectra as inputs and predicts the rate of rating
% disagreement in expert observers comparing the two colors side-by-side.
% Higher values indicate more metamerism and conversely more disagreement.
% Inputs:
% - Spectrum1, wavelengths1 - Spectral radiance data measured at
% wavelengths specified in wavelengths1 (1 x m).
% - Spectrum2, wavelengths2 - Spectral radiance data measured at
% wavelengths specified in wavelengths1 (1 x n). m and n don't need to
% match.
% Output:
% COMFI_Output - The measure of observer metameric failure between the two
% input spectra (scalar).
%
% COMFI assumes the DEITP color difference between the two input spectra is
% lower than 15 for the CIE 1931 standard observer. 

persistent CMFs;
if isempty(CMFs)
    CMFs = getfield(load('./GeneratedCMFs.mat'),'Individual_CMFs');
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
        DEITPs(i) = 720 * norm((ITP1 - ITP2) .*[1 0.5 1]);
end
ITP_StdDev = std(DEITPs);
COMFI_Output = 0.2 + 0.221./(1+exp(-1.284*(ITP_StdDev - 1.625)));
end

