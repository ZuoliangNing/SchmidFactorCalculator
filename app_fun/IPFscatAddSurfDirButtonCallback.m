function IPFscatAddSurfDirButtonCallback(~,~,app)
fun = @(obj) str2double(obj.String);
val = arrayfun(fun,app.IPFscatUic.Edit(1:3));
if any(isnan(val)) ; return ; end
val = val./norm(val);

app.IPFscatFig.UserData.SurfNum = app.IPFscatFig.UserData.SurfNum +1;
app.IPFscatUic.ListBox.String = [app.IPFscatUic.ListBox.String; ...
    ['N',num2str(app.IPFscatFig.UserData.SurfNum)]];
app.IPFscatFig.UserData.VecData = [app.IPFscatFig.UserData.VecData;
    val];
val2 = app.CoordinaterealtionMatrix * val';
app.IPFscatFig.UserData.VecSampleData = ...
    [app.IPFscatFig.UserData.VecSampleData;
     val2'];