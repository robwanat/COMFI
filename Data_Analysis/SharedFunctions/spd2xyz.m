function XYZ = spd2xyz(sprad, wavelengths,CMFs, CmfWavelengths)
%SPD2XYZ Summary of this function goes here
%   Detailed explanation goes here
if ~exist('CMFs', 'var')
    xyz31 = csvread('ciexyz31_1.csv');
    CMFs = xyz31(:,2:end)';
    CmfWavelengths = xyz31(:,1);
end
scaler  =683;
NewWavelengthLimits = [max(CmfWavelengths(1), wavelengths(1)) min(CmfWavelengths(end), wavelengths(end))];
NewWavelengths = NewWavelengthLimits(1) : NewWavelengthLimits(2);
for i =1 :3
%     XYZ(i) = 0;
%     for j =1:size(SPD,1)
        XYZ(i) =  scaler*trapz(NewWavelengths, interp1(wavelengths, sprad, NewWavelengths).*interp1(CmfWavelengths,CMFs(i,:),NewWavelengths));
%         altXYZ(i) = scaler * sum(interp1(wavelengths, sprad, NewWavelengths).*interp1(CmfWavelengths,CMFs(i,:),NewWavelengths));
%     end
end
end
