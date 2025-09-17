function HCPdemoCloseRequestFcn(fig,~,app)
app.HCPdemoMenu.Checked = 'off';
app.HCPPlotFlag = 0;
if ~app.SliTraFlag
    app.FreezeButton.Enable = 'off';
    if app.FreezeButton.Value
        app.FreezeButton.Value = 0;
        app.SliTraFreFlag = 0;
    end
    if ishandle(app.SliTraFreSca)
        delete(app.SliTraFreSca);
    end
end
delete(fig);