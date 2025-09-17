function UIFigureButtonDownFcn(fig,~,app)
pos = app.UIAxes.CurrentPoint(1,1:2);
if pos(1)<app.UIAxes.XLim(1) || pos(1)>app.UIAxes.XLim(2) ...
        || pos(2)<app.UIAxes.YLim(1) || pos(2)>app.UIAxes.YLim(2)
        return
end
app.CurAxePos = pos;

a = app.test(app.PloNo);
n = app.CatNo;

if ishandle(app.TemSca)
    delete(app.TemSca);
    delete(app.TemLab);
end

dis = vecnorm([a.X-pos(1),a.Y-pos(2)],2,2);
ind = find(dis==min(dis));
loc = [a.X(ind),a.Y(ind)];
Angle = a.EulerAngles(ind,:);
SFs = a.SchmidtFactors(ind,a.SelectedCategoryColumnInd{n});
maxSF = max(SFs);

app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n)+1,app.CatNo)...
    .loc = loc;
app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n)+1,app.CatNo)...
    .Angle = Angle;
app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n)+1,app.CatNo)...
    .SFs = SFs;
app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n)+1,app.CatNo)...
    .maxSF = maxSF;
RefreshQueryTable(app)

app.TemSca = ...
     scatter(app.UIAxes,pos(1),pos(2),5,'r','filled');
pos = fig.CurrentPoint;
pos = [pos,30,20];
pos(1:2) = pos(1:2)-app.RightPanel.Position(1:2);
app.CurPanPos = pos;
app.TemLab = ...
    uilabel(app.RightPanel, ...
    'Text',['P',num2str(app.test(app.PloNo).QueryNum(n)+1)], ...
    'FontSize',15, ...
    'Position',pos, ...
    'FontColor',[1,0,0]);
