function plotGamut(drawFaces, drawColors)
%% A function to plot a 2D gamut in CIE 1931 xy chromaticity space
if ~exist('drawFaces', 'var') || isempty(drawFaces)
    drawFaces = 1;
end
if ~exist('drawColors', 'var') || isempty(drawColors)
    drawColors = 1;
end
CIEdata = load('ciexyz31_1.csv');
wl = CIEdata(:,1);
x_bar = CIEdata(:,2);
y_bar = CIEdata(:,3);
z_bar = CIEdata(:,4);
% x_bar, etc are column vectors at wavelengths, wl.
x = x_bar./(x_bar + y_bar + z_bar);
y = y_bar./(x_bar + y_bar + z_bar);
 
wl = wl(:);
n = length(wl);

% blue blue cyan green yellow orange red red
wl0 = [360 470 492 520 575 600 630 830]'; % wavelengths in nm.
rgb0 = [0 0 1;0 0 1;0 1 1;0 1 0;1 1 0;1 0.5 0;1 0 0;1 0 0];
rgb = [pchip(wl0,rgb0(:,1),wl), pchip(wl0,rgb0(:,2),wl),...
    pchip(wl0,rgb0(:,3),wl)];
 
for k = 1:n-1
    if ~drawFaces
        rgb2 = [1 1 1];
    else
    rgb2 = permute([1 1 1;rgb(k,:);rgb(k+1,:)],[1 3 2]);
    end
    if drawColors
        hLine = patch([1/3;x(k:k+1)],[1/3;y(k:k+1)],rgb2,'edgecolor','none');
        set(get(get(hLine,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    end
end
if drawFaces
    rgb2 = permute([1 1 1;rgb(end,:);rgb(1,:)],[1 3 2]);
else
    rgb2 = [1 1 1];
end
if drawColors
    hLine = patch([1/3;x([end 1])],[1/3;y([end 1])],rgb2,'edgecolor','none');
    set(get(get(hLine,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
end
 
hLine = patch(x,y,'-k','facecolor','none','edgecolor','k', 'LineWidth',2);
set(get(get(hLine,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
 
% hold on
% hLine = plot(1/3,1/3,'ok');
% set(get(get(hLine,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% hold off
 
axis equal
axis([0 .75 0 .85])
end