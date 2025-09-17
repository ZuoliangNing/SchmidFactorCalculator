function a = PlotSF(a,n,app,flag)
app.UIAxes.Visible = 'on';
app.UIAxes.XAxis.Visible = 'off';
app.UIAxes.YAxis.Visible = 'off';
% delete(findobj(app.UIAxes.Children, ...
%     '-not','Type','scatter', ...
%     '-not','Type','image'));

fun = @(t) cellfun(@ObjVisibleOff,t.QueryScatter);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.Plot);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.IPF);
arrayfun(fun,app.test);
fun = @(t) cellfun(@ObjVisibleOff,t.QueryText);
arrayfun(fun,app.test);
a.Plot{n}.Visible = 'on';

app.UIAxes.View = [0,90];
axis(app.UIAxes,'image');
app.UIAxes.YDir = 'reverse';
app.UIAxesColorbar = colorbar(app.UIAxes);
% if flag
%     app.UIAxes.CLim = [0,0.5];
% else
%     app.UIAxes.CLim = [-0.5,0.5];
% end
xlabel(app.UIAxes,'');
ylabel(app.UIAxes,'');
box(app.UIAxes,'off');
cellfun(@ObjVisibleOn,a.QueryScatter(:,n))
cellfun(@ObjVisibleOn,a.QueryText(:,n))