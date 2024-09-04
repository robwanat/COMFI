function CalibrationMatrix = spectra2calibration(spectra, spectrawavelengths)
%SPECTRA2CALIBRATION Summary of this function goes here
%   Detailed explanation goes here
CalibrationMatrix = zeros(3,3);
CMF = csvread('ciexyz31_1.csv');
CMFWavelengths = CMF(:,1);
CMF = CMF(:,2:end);
if size(spectra, 2) < 5
    spectra = spectra';
end
NewWavelengthLimits = [max(CMFWavelengths(1), spectrawavelengths(1)) min(CMFWavelengths(end), spectrawavelengths(end))];
NewWavelengths = NewWavelengthLimits(1) : NewWavelengthLimits(2);

for i =1 :3 %for R G B
    for j = 1:3 % for x,y,z
        CalibrationMatrix(i,j) = 683 * trapz(NewWavelengths, interp1(spectrawavelengths, spectra(i,:),NewWavelengths).*interp1(CMFWavelengths, CMF(:,j), NewWavelengths));
    end
end
end
