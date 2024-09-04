function Lab = XYZ2Lab(XYZ,XYZn)
nanInd = isnan(XYZ);
XYZ(nanInd) = 0;
XYZ = bsxfun(@rdivide,XYZ,XYZn);
L = 116.*(f(XYZ(:,2)))-16;
a = 500.*(f(XYZ(:,1))-f(XYZ(:,2)));
b = 200.*(f(XYZ(:,2))-f(XYZ(:,3)));
Lab = [L,a,b];
Lab(nanInd) = nan;

end

function out = f(in)

d = 6/29;
out = zeros(size(in));
out( in > d^3) = in(in>d^3).^(1./3);
out( in<= d^3) = in(in<=d^3)./(3.*d.^2)+(4./29);

end