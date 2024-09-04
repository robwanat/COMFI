function POMI_Result = CalcOMFI_DE2000(Spectrum1, wavelengths1, Spectrum2, wavelengths2, Params)
%% Calculate the DE2000 values between two compared spectra for each of the individual CMFs
% Spectrum-wavelengths pairs describe each spectral radiance, Params is a
% triplet of kL, kC and kH values as defined by CIE DE2000
persistent CMFs;
if isempty(CMFs)
    CMFs = getfield(load('../GeneratedCMFs.mat'),'Individual_CMFs');
end
if ~exist('Params', 'var') || isempty(Params)
    Params = [1 1 1];
end
SPDWavelengths = 390:5:780;
DE00s = zeros(size(CMFs,3),1);
for i = 1:size(CMFs,3)
        CurrentCMF = CMFs(:,:,i)';
        OutputXYZ1 = spd2xyz(Spectrum1, wavelengths1, CurrentCMF, SPDWavelengths);
        OutputXYZ2 = spd2xyz(Spectrum2, wavelengths2, CurrentCMF, SPDWavelengths);
        OutputLAB1 = XYZ2Lab(OutputXYZ1,whitepoint('D65')*100);
        OutputLAB2 = XYZ2Lab(OutputXYZ2,whitepoint('D65')*100);
        DE00s(i) = de2000(OutputLAB1,OutputLAB2,Params);
end
POMI_Result = DE00s;