function IPFscatAddDirButtonCallback(~,~,app)
fun = @(obj) str2double(obj.String);
val = arrayfun(fun,app.IPFscatUic.Edit(4:6));
if any(isnan(val)) ; return ; end
val = val./norm(val);

app.IPFscatFig.UserData.DirNum = app.IPFscatFig.UserData.DirNum +1;
app.IPFscatUic.ListBox.String = [app.IPFscatUic.ListBox.String; ...
    ['D',num2str(app.IPFscatFig.UserData.DirNum)]];
app.IPFscatFig.UserData.VecData = [app.IPFscatFig.UserData.VecData;
    val];
val2 = app.CoordinaterealtionMatrix * val';
app.IPFscatFig.UserData.VecSampleData = ...
    [app.IPFscatFig.UserData.VecSampleData;
     val2'];