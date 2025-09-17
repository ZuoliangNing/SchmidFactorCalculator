function PlotHCP_Surf(X,Y,Z,axe)
for i =1:5
    ind = [i,i+1,i+7,i+6];
    HCPSurf(X(ind),Y(ind),Z(ind),axe)
end
ind = [6,1,7,12];
HCPSurf(X(ind),Y(ind),Z(ind),axe)
ind = 1:6;
HCPSurf(X(ind),Y(ind),Z(ind),axe)
ind = 7:12;
HCPSurf(X(ind),Y(ind),Z(ind),axe)
end
function HCPSurf(x,y,z,axe)
c = 0.9*[1,1,1];
% c = [0,0,0];
fill3(axe,x,y,z, ...
    c, ...
    'FaceAlpha',0.8, ...
    'LineWidth',2, ...
    'EdgeAlpha',1)
end