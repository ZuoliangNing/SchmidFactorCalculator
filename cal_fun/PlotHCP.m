function PlotHCP(app)
% Plot HCP
if isempty(app.test) || isempty(app.PloNo)  || isnan(app.PloNo)
    delete(app.HCPPlotAxe.Children);
    return
end
axe = app.HCPPlotAxe;
axis(axe, 'equal')
axis(axe,'tight')
axis(axe,'off')
if app.SliTraFreFlag
   return 
end
delete(axe.Children);
if isempty(app.test)||isempty(app.PloNo)
   return 
end
if app.PloTyp == 2
    return
end
pos = app.UIAxes.CurrentPoint(1,1:2);
if pos(1)<app.UIAxes.XLim(1)||pos(1)>app.UIAxes.XLim(2)...
        ||pos(2)<app.UIAxes.YLim(1)||pos(2)>app.UIAxes.YLim(2)
    return
end
a = app.test(app.PloNo);
dis = vecnorm([a.X-pos(1),a.Y-pos(2)],2,2);
n = dis == min(dis);
Angle = a.EulerAngles(n,:);
A = 1;
B = A/2*sqrt(3); 
% C = A * a.AxialRatio;
C = A * 1.6;
HCPCoordCrystalX = ...
    repmat([-0.5*A , -A , -0.5*A , 0.5*A , A , 0.5*A] ,1,2);
HCPCoordCrystalY = ...
    repmat([B , 0 , -B , -B , 0 , B] ,1,2);
HCPCoordCrystalZ = ...
    [-C/2*ones(1,6),C/2*ones(1,6)];

coord = [HCPCoordCrystalX;HCPCoordCrystalY;HCPCoordCrystalZ];
% coord2 = [-0.5*A,0,0.5*A;
%           -sqrt(3)*A/6,sqrt(3)*A/3,-sqrt(3)*A/6; 
%           0,0,0];
if strcmp(a.ConvertMethod,'CHANNEL5')
    Gchannel5 = [cos(pi/6),-1/2,0;
             1/2,cos(pi/6),0;
             0,0,1];
    coord = Gchannel5 * coord;
end
g = Euler_Matrix_1(Angle(1),Angle(2),Angle(3)); % sam -> cry
g = g'; % cry -> sam
coord = g * coord;
% coord2 = g * coord2;
% mark slip direction of variant with the maximum SF


if strcmp(a.ConvertMethod,'OIM')
    G = [0,-1,0;1,0,0;0,0,1];
    coord = G * coord;
end
PlotHCP_Surf(coord(1,:),coord(2,:),coord(3,:),axe);
% scatter3(axe,coord2(1,:),coord2(2,:),coord2(3,:), ...
%     15,'r','filled')
% scatter3(axe,coord(1,:),coord(2,:),coord(3,:), ...
%     15,'r','filled')
end
