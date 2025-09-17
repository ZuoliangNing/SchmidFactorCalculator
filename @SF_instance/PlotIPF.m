function a = PlotIPF(a,n,app)
app.UIAxes.Visible = 'on';
app.UIAxes.XAxis.Visible = 'off';
app.UIAxes.YAxis.Visible = 'off';
fun = @(t) cellfun(@ObjVisibleOff,t.QueryScatter);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.Plot);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.IPF);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.QueryText);
arrayfun(fun,app.test);
a.IPF{n}.Visible = 'on';

app.UIAxes.View = [0,90];
axis(app.UIAxes,'image');
app.UIAxes.YDir = 'reverse';
app.UIAxesColorbar = colorbar(app.UIAxes);
app.UIAxesColorbar.Visible = 'off';
xlabel(app.UIAxes,'');
ylabel(app.UIAxes,'');
box(app.UIAxes,'off');