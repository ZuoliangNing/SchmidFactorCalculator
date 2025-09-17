function PlotSlipTrace(app)
if isempty(app.test) || isempty(app.PloNo)  || isnan(app.PloNo)
    return
end
if app.SliTraFreFlag
   return 
end

if ishandle(app.SliTraLines)
   delete(app.SliTraLines);
end

if app.PloTyp == 2
    app.SliTraTable.Data = '';
    app.SliTraText.String = '';
    return
end

node = app.Tree.SelectedNodes;
pos = app.UIAxes.CurrentPoint(1,1:2);
if pos(1)<app.UIAxes.XLim(1)||pos(1)>app.UIAxes.XLim(2)...
        ||pos(2)<app.UIAxes.YLim(1)||pos(2)>app.UIAxes.YLim(2)
    app.SliTraTable.Data = '';
    app.SliTraText.String = '';
    return
end
a = app.test(app.PloNo);
dis = vecnorm([a.X-pos(1),a.Y-pos(2)],2,2);
n = find(dis==min(dis));
n = n(1);
Angle = a.EulerAngles(n,:);
g = Euler_Matrix_1(Angle(1),Angle(2),Angle(3));
g = g';
loc = [a.X(n),a.Y(n)];
str = {['X: ',num2str(loc(1)),', Y: ',num2str(loc(2))], ...
    ['Euler Angles: ',num2str(Angle)]};
app.SliTraText.String = str;

% SFCMap = slanCM('parula');
% SFColor = @(val) SFCMap( ...
%     round( rescale( val, 1, 255, ...
%     'InputMin', 0, 'InputMax', 0.5 ) ), : );

if isa(node.Parent.Parent.Parent,'matlab.ui.container.Tree')
    switch node.Parent.Text
        case 'Schmidt factors'
            SFs = a.SchmidtFactors(n,a.SelectedCategoryColumnInd{app.CatNo});
            num = length(SFs);
            LinWid = 40*abs(SFs);
            LinWid(LinWid==0) = 0.01;
            sfind = find(SFs<0);
            LinSty = arrayfun(@(i)'-',1:num,'UniformOutput',false);
            Col = app.Colors;
            switch num
                case 3
                    Col = Col(1:6:end,:);
                case 6
                    Col = Col(1:3:end,:);
            end
            for i = 1:length(sfind)
               LinSty{sfind(i)} = '--'; 
            end
            nam = arrayfun(@(i) ['Var',num2str(i)], ...
                    1:app.test(1).DeformationSystemsNumberList( ...
                    a.CalculateList(app.CatNo)), ...
                    'UniformOutput',false);
            ind = a.SelectedCategoryColumnInd{app.CatNo};
            Dirs = a.SelectedSurfaceNormal3Crystal(:,ind);
%             Dirs = a.SelectedDirection3Crystal(:,ind);

            Dirs = g * Dirs;
            Theta = atan2(Dirs(2,:),Dirs(1,:));
        
            app.Temp.Dirs = Dirs;
            fun = @(i) polarplot(app.SliTraAxe, ...
                [Theta(i),Theta(i)],[1,-1], ...
                'Linewidth',LinWid(i), ...16
                'LineStyle',LinSty{i}, ...
                'Color',Col(i,:), ...SFColor(SFs(i))
                'DisplayName',nam{i});
            app.SliTraLines = arrayfun(fun,1:num);

            app.SliTraTable.Data = SFs; 
        case 'IPF'
            SFs = a.MaximumSchmidtFactors(n,:);
            num = length(SFs);
            LinWid = 40*abs(SFs);
            LinWid(LinWid==0) = 0.01;
            sfind = find(SFs<0);
            LinSty = arrayfun(@(i)'-',1:num,'UniformOutput',false);
            Col = app.Colors(1:floor(18/num):end,:);
            for i = 1:length(sfind)
               LinSty{sfind(i)} = '--'; 
            end
            nam = {a.CategoryListNodes1.Text};
            
            ind = arrayfun(@(i)a.SelectedCategoryColumnInd{i} ...
                (a.MaximumSchmidtFactorsIndex(n,i)), ...
                1:a.SelectedCategoryNumber);
            SelectedSurfaceNormal3Crystal = a.SelectedSurfaceNormal3Crystal(:,ind);
            Dirs = g * SelectedSurfaceNormal3Crystal;
            
            Theta = atan2(Dirs(2,:),Dirs(1,:));
            app.Temp.Dirs = Dirs;
            fun = @(i) polarplot(app.SliTraAxe, ...
                [Theta(i),Theta(i)],[1,-1], ...
                'Linewidth',LinWid(i), ...
                'LineStyle',LinSty{i}, ...
                'Color',Col(i,:), ...
                'DisplayName',nam{i});
            app.SliTraLines = arrayfun(fun,1:num);
                   
            app.SliTraTable.Data = SFs; 
    end
end