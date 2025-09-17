function PlotPFscatter(app)
if isempty(app.test) || isempty(app.PloNo)  || isnan(app.PloNo)
    delete(app.PFscatAxe.Children);
    app.PFscatUic.Text.String = '';
    return
end
if app.SliTraFreFlag
   return 
end
delete(app.PFscatAxe.Children);
if app.PloTyp == 2
    app.PFscatUic.Text.String = '';
    return
end
theta = 0:0.01:2*pi;
r = ones(1,length(theta));
polarplot(app.PFscatAxe,theta,r,'LineWidth',1,'Color','black');
polarplot(app.PFscatAxe,[0,pi],[1,1],'LineWidth',0.5,'Color','black');
polarplot(app.PFscatAxe,[pi/2,3*pi/2],[1,1],'LineWidth',0.5,'Color','black');
text(app.PFscatAxe,0,1.1,'X');text(app.PFscatAxe,pi/2,1.1,'Y');
pos = app.UIAxes.CurrentPoint(1,1:2);
if pos(1)<app.UIAxes.XLim(1)||pos(1)>app.UIAxes.XLim(2)...
        ||pos(2)<app.UIAxes.YLim(1)||pos(2)>app.UIAxes.YLim(2)
    app.PFscatUic.Text.String = '';
    legend off
    return
end
a = app.test(app.PloNo);
dis = vecnorm([a.X-pos(1),a.Y-pos(2)],2,2);
n = find(dis==min(dis));
n = n(1);
Angle = a.EulerAngles(n,:);
loc = [a.X(n),a.Y(n)];
str = {['X: ',num2str(loc(1)),', Y: ',num2str(loc(2))], ...
    ['Euler Angles: ',num2str(Angle)]};
app.PFscatUic.Text.String = str;
g = Euler_Matrix_1(Angle(1),Angle(2),Angle(3));
g = g';
Colors = colororder;
Colors = [0,1,1;Colors;1,1,0];
% calculations start here
objs = [];
if app.PFscatOpt(1)
    % direction PF
    % start here
    d = app.PFscatInd(1,:);
    if d(4)<0 ; d = -d; end
    temp = unique(perms(d(1:3)),'rows');
    nd = size(temp,1);
    Directions4Crystal = [temp,d(4)*ones(nd,1); ...
                          -temp,d(4)*ones(nd,1)];
    names = arrayfun(@(i) num2str(Directions4Crystal(i,:)), ...
        1:2*nd,'UniformOutput',false);
    [Directions4Crystal,ia0] = unique(Directions4Crystal,'rows');
    names = names(ia0);
    if d(4)~=0
        Directions4Crystal = [Directions4Crystal;-Directions4Crystal];
        names = [names,names];
    end
    Directions3Crystal = ...
        DirectionIndexConvert(Directions4Crystal,...
        a.AxialRatio,a.ConvertMethod);
    Directions3Sample = g * Directions3Crystal;
    ind = Directions3Sample(3,:)>=0;
    Directions3Sample = Directions3Sample(:,ind);
    Z = Directions3Sample(3,:);
    names = names(ind);
    [theta,rho] = cart2pol(Directions3Sample(1,:),Directions3Sample(2,:));
    R = rho./(1+Z);
    if app.PFscatOpt(4)
        fun = @(i) polarplot(app.PFscatAxe, ...
            theta(i),R(i), ...
            'LineStyle','none', ...
            'Marker','o', ...
            'MarkerSize',4, ...
            'Color',Colors(i,:), ...
            'DisplayName',names{i});
        objs = arrayfun(fun,1:length(theta));
    else
        polarplot(app.PFscatAxe,theta,R, ...
            'LineStyle','none', ...
            'Marker','o', ...
            'MarkerSize',4, ...
            'Color','r');
    end
    % end here
end
if app.PFscatOpt(2)
    % surface trace
    % start here
    d = app.PFscatInd(2,:);
    if d(4)<0 ; d = -d; end
    temp = unique(perms(d(1:3)),'rows');
    nd = size(temp,1);
    Directions4Crystal = [temp,d(4)*ones(nd,1); ...
                          -temp,d(4)*ones(nd,1)];
    names = arrayfun(@(i) num2str(Directions4Crystal(i,:)), ...
        1:2*nd,'UniformOutput',false);
    [Directions4Crystal,ia0] = unique(Directions4Crystal,'rows');
    names = names(ia0);
    if d(4) == 0 % prismatic - 3 v
       [~,ia,~] =  unique(abs(Directions4Crystal),'rows');
       Directions4Crystal = Directions4Crystal(ia,:);
       names = names(ia);
    end
    
    Directions3Crystal = ...
        SurfaceNormalIndexConvert(Directions4Crystal,...
        a.AxialRatio,a.ConvertMethod);
    Directions3Sample = g * Directions3Crystal;
    for i = 1:1:size(Directions3Sample,2)
        x = -1:0.001:1;
        d1 = Directions3Sample(1,i);
        d2 = Directions3Sample(2,i);
        d3 = Directions3Sample(3,i);
        if d3~=0
            delta = 1-d1^2-x.^2;
            ind = delta>=0;
            x = x(ind);
            delta = delta(ind);
            y = [(-d1*d2*x+d3*sqrt(delta)),flip((-d1*d2*x-d3*sqrt(delta)))]/(1-d1^2);
            x1 = [x,flip(x),x(1)];
            y1 = [y,y(1)];
            z1 = -(d1*x1+d2*y1)/d3;
            ind = z1>=0;
            x1 = x1(ind); y1 = y1(ind); z1 = z1(ind);
        else
            x1 = x;
            y1 = -d1/d2*x;
%             ind = (x1.^2+y1.^2)<=1;
%             x1 = x1(ind); y1 = y1(ind);
            z1 = sqrt(1-x1.^2-y1.^2);
            z1 = real(z1);
        end
        [theta,rho] = cart2pol(x1,y1);
        R = rho./(1+z1);
        [theta,I] = sort(theta);
        R = R(I);
        theta1 = theta;
%         theta1(theta1<0) = theta1(theta1<0)+2*pi;
        dd = abs(diff(theta1));
        ind = find(dd==max(dd));
        if max(dd)>0.3
            theta = [theta(ind+1:end),theta(1:ind-1)];
            R = [R(ind+1:end),R(1:ind-1)];
        end
        if app.PFscatOpt(4)
            o = polarplot(app.PFscatAxe,theta,R, ...
                'Color',Colors(i,:), ...
                'DisplayName',names{i});
            objs = [objs,o];
        else
            polarplot(app.PFscatAxe,theta,R,'Color',[1,0.3,0.3]);
        end
    end
    % end here
end
if app.PFscatOpt(3)
    % surface pole
    % start here
    d = app.PFscatInd(3,:);
    if d(4)<0 ; d = -d; end
    temp = unique(perms(d(1:3)),'rows');
    nd = size(temp,1);
    Directions4Crystal = [temp,d(4)*ones(nd,1); ...
                          -temp,d(4)*ones(nd,1)];
    names = arrayfun(@(i) num2str(Directions4Crystal(i,:)), ...
        1:2*nd,'UniformOutput',false);
    [Directions4Crystal,ia0] = unique(Directions4Crystal,'rows');
    names = names(ia0);
    if d(4)~=0
        Directions4Crystal = [Directions4Crystal;-Directions4Crystal];
        names = [names,names];
    end
    Directions3Crystal = ...
        SurfaceNormalIndexConvert(Directions4Crystal,...
        a.AxialRatio,a.ConvertMethod);
    Directions3Sample = g * Directions3Crystal;
    ind = Directions3Sample(3,:)>=0;
    names = names(ind);
    Directions3Sample = Directions3Sample(:,ind);
    Z = Directions3Sample(3,:);
    [theta,rho] = cart2pol(Directions3Sample(1,:),Directions3Sample(2,:));
    R = rho./(1+Z);
    if app.PFscatOpt(4)
        fun = @(i) polarplot(app.PFscatAxe, ...
            theta(i),R(i), ...
            'LineStyle','none', ...
            'Marker','.', ...
            'MarkerSize',12, ...
            'Color',Colors(i,:), ...
            'DisplayName',names{i});
        o1 = arrayfun(fun,1:length(theta));
        objs = [objs,o1];
    else
        polarplot(app.PFscatAxe,theta,R, ...
            'LineStyle','none', ...
            'Marker','.', ...
            'MarkerSize',12, ...
            'Color','r');
    end
    % end here
end
if app.PFscatOpt(4)
    legend(app.PFscatAxe,objs);
else
    legend(app.PFscatAxe,'off')
end

