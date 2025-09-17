function SliTraFigCloseRequestFcn(fig,~,app)
app.SliptraceMenu.Checked = 'off';
app.FreezeButton.Enable = 'off';
app.SliTraFlag = 0;
if app.FreezeButton.Value
    app.FreezeButton.Value = 0;
    app.SliTraFreFlag = 0;
end
if ishandle(app.SliTraFreSca)
    delete(app.SliTraFreSca);
end
delete(fig);