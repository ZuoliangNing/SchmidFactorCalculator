function FreezeButtonPushedFcn(button,~,app)
if ~button.Value
    app.SliTraFreFlag = 0;
    if ishandle(app.SliTraLines)
       delete(app.SliTraLines);
       app.SliTraTable.Data = '';
    end
    if ishandle(app.SliTraFreSca)
        delete(app.SliTraFreSca);
    end
else
    app.SliTraFreFlag = 1;
    pos = app.UIAxes.CurrentPoint(1,1:2);
    app.CurAxePos = pos;
    app.SliTraFreSca = scatter(app.UIAxes,pos(1),pos(2),5,'r','filled');
end