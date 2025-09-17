function Delete(a,app)
fun = @(obj) delete(obj);
cellfun(fun,a.QueryScatter);
cellfun(fun,a.Plot);
cellfun(fun,a.IPF);
cellfun(fun,a.GrainBoundaryPlot)
delete(a.Node);
cellfun(fun,a.QueryText);
app.test(arrayfun(@(b)(b.No),app.test) == a.No) = [];
fun = @(t) cellfun(@ObjVisibleOff,t.QueryText);
arrayfun(fun,app.test);
app.UIAxes.Visible = 'off';
colorbar(app.UIAxes,'off');
app.TextArea.Value = '';
app.PloNo = 0;
app.CatNo = 0;
app.DeleteButton.Enable = 'off';
app.GBButton.Enable = 'off';
app.QueryButton.Enable = 'off';
