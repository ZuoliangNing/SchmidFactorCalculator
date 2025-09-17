function UIFigureKeyPress (~,KeyData,app)
if ~app.SliTraFlag && ~app.PFscatFlag && ~app.HCPPlotFlag && ~app.IPFscatFlag
    return 
end
key = KeyData.Key;
if ~strcmp(key,'f')
    return
end
button = app.FreezeButton;
if button.Value
    button.Value = 0;
    app.SliTraFreFlag = 0;
    if ishandle(app.SliTraFreSca)
        delete(app.SliTraFreSca);
    end
else
    button.Value = 1;
    app.SliTraFreFlag = 1;
    pos = app.UIAxes.CurrentPoint(1,1:2);
    app.CurAxePos = pos;
    app.SliTraFreSca = scatter(app.UIAxes,pos(1),pos(2),15,'r','filled');
end

