function POMI_Result = CalcOMFI_DE2000_ModParams(Spectrum1, wavelengths1, Spectrum2, wavelengths2)
%% This script is used to quickly test different de2000 parameter values, 
% without the need to recalculate the XYZ colors for each parameter value, 
% reducing computational overhead, otherwise the file is functionally the
% same as Calc_OMFI_DE2000
persistent CMFs;
if isempty(CMFs)
    CMFs = getfield(load('../GeneratedCMFs.mat'),'Individual_CMFs');
end

SPDWavelengths = 390:5:780;

ParameterSpacing = linspace(0.2,2,10);
OMFI_DE2000_ModParams = zeros(518,3,10);
for i = 1:size(CMFs,3)
        CurrentCMF = CMFs(:,:,i)';
        OutputXYZ1 = spd2xyz(Spectrum1, wavelengths1, CurrentCMF, SPDWavelengths);
        OutputXYZ2 = spd2xyz(Spectrum2, wavelengths2, CurrentCMF, SPDWavelengths);
        OutputLAB1 = XYZ2Lab(OutputXYZ1,whitepoint('D65')*100);
        OutputLAB2 = XYZ2Lab(OutputXYZ2,whitepoint('D65')*100);    
        for k = 1:10
            OMFI_DE2000_ModParams(i,1,k) = de2000(OutputLAB1,OutputLAB2,[ParameterSpacing(k) 1 1]);
            OMFI_DE2000_ModParams(i,2,k) = de2000(OutputLAB1,OutputLAB2,[1 ParameterSpacing(k) 1]);
            OMFI_DE2000_ModParams(i,3,k) = de2000(OutputLAB1,OutputLAB2,[1 1 ParameterSpacing(k)]);
        end
end
POMI_Result = OMFI_DE2000_ModParams;
