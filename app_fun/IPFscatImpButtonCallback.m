function IPFscatImpButtonCallback(~,~,app)
try %#ok<TRYNC>
    rmappdata(app.IPFscatFig,'NormalVector')
end
app.SurfaceNormalVectorCalculator = SurfaceNormalVectorCalculator;
app.SurfaceNormalVectorCalculator.ExCallFlag = true;
setappdata(app.SurfaceNormalVectorCalculator.UIFigure,'RootApp',app)
while ~isappdata(app.IPFscatFig,'NormalVector')
    pause(0.5)
end

NormalVector = getappdata(app.IPFscatFig,'NormalVector');
if isempty(NormalVector)
    return
end
app.IPFscatFig.UserData.SurfNum = app.IPFscatFig.UserData.SurfNum +1;
app.IPFscatUic.ListBox.String = [app.IPFscatUic.ListBox.String; ...
    ['N',num2str(app.IPFscatFig.UserData.SurfNum)]];
app.IPFscatFig.UserData.VecData = [app.IPFscatFig.UserData.VecData;
    NormalVector'];
NormalVectorSample = app.CoordinaterealtionMatrix * NormalVector;
app.IPFscatFig.UserData.VecSampleData = ...
    [app.IPFscatFig.UserData.VecSampleData;
     NormalVectorSample'];
app.SurfaceNormalVectorCalculator = [];