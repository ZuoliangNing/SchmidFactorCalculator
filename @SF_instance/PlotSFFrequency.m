function a = PlotSFFrequency(a,n,app)
app.UIAxes.Visible = 'on';
app.UIAxes.XAxis.Visible = 'on';
app.UIAxes.YAxis.Visible = 'on';
delete(findobj(app.UIAxes.Children, ...
    'Type','histogram'));
fun = @(t) cellfun(@ObjVisibleOff,t.QueryScatter);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.Plot);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.IPF);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.QueryText);
arrayfun(fun,app.test);
h = histogram(a.Axe, ...
    'BinEdges',a.SchmidtFactorsFrequencyEdges{n}', ...
    'BinCounts',a.SchmidtFactorsFrequency{n}*100, ...
    'FaceColor',[0,0.4470,0.7410]);
xlabel(app.UIAxes,'Schmidt factor');
ylabel(app.UIAxes,'Frequency /%');
colorbar(app.UIAxes,'off');
axis(app.UIAxes,'normal');
app.UIAxes.YDir = 'normal';
box(app.UIAxes,'on');
% if 