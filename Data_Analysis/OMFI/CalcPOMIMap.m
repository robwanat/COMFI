function CalcPOMIMap(DisplayName)
%% Generate the data needed to plot POMI maps in the paper using Macbeth spectra as reference
% DisplayNames can be either 'Projector', 'VG246' (Gaming Monitor) or
% 'X310' (reference monitor)
Spectra = [csvread('./Macbeth Red.csv') csvread('./Macbeth Green.csv'), csvread('./Macbeth Blue.csv')]/100;
wavelengths = csvread('wavelengths.csv');

X310 = load(['../DisplayMeasurements/' DisplayName '_Spectra.mat']);
Spectra2 = X310.([DisplayName '_Spectra']);
Spectra2 = Spectra2(1:3,:);
wavelengths2 = 380:780;

RGB2XYZMatrix = spectra2calibration(Spectra', wavelengths');
PrimaryXYZ = eye(3) * RGB2XYZMatrix;
Primaryxyz = PrimaryXYZ ./sum(PrimaryXYZ,2);
NrPoints = 500;
NrPointsEdge = floor(sqrt(NrPoints*2)-1);
PointsDistributionxy = triangle_grid(NrPointsEdge, Primaryxyz(:,1:2)');
PointsDistributionxy = [ [0.3127 0.329]' PointsDistributionxy];
PointsDistributionXYZ = xyY2xyz([PointsDistributionxy' ones(size(PointsDistributionxy,2),1).*18]);
PointsDistributionRGB = PointsDistributionXYZ / RGB2XYZMatrix;

RGB2XYZMatrix2 = spectra2calibration(Spectra2, wavelengths2);
PointsDistributionXYZ2 = xyY2xyz([PointsDistributionxy' ones(size(PointsDistributionxy,2),1).*18]);
PointsDistributionRGB2 = PointsDistributionXYZ2 / RGB2XYZMatrix2;
POMIFunction = @(x,y)(CalcOMFI_DEITP(x, wavelengths, y, wavelengths2));

POMI_Result = zeros(1,size(PointsDistributionRGB,1));
for i = 1:size(PointsDistributionRGB,1)
    disp(i);
    SpectraDistribution = PointsDistributionRGB(i,:) * Spectra';
    SpectraDistribution2 = PointsDistributionRGB2(i,:) * Spectra2;
    POMI_Result(i) = std(POMIFunction(SpectraDistribution, SpectraDistribution2),0);
end
POMI = 0.2 + 0.221./(1+exp(-1.284*(POMI_Result - 1.625)));
save([DisplayName '_POMIMap.mat'], "POMI","PointsDistributionxy");