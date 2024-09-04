function XYZ=xyY2xyz(xyY)
XYZ(:,2) = xyY(:,3);
XYZ(:,1) = XYZ(:,2) ./ xyY(:,2) .* xyY(:,1);
XYZ(:,3) = XYZ(:,2) ./ xyY(:,2) .* (1 - xyY(:,1) - xyY(:,2));
end