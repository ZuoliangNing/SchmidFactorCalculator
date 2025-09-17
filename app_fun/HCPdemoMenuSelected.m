function HCPdemoMenuSelected(menu,~,app)
if strcmp(menu.Checked, 'off')
    menu.Checked = 'on';
    app.FreezeButton.Enable = 'on';
    app.HCPPlotFlag = 1;
    pos = app.SchmidtfactorcalculatorUIFigure.Position;
    pos(1) = pos(1)+pos(3)+20;
    pos(2) = pos(2)+pos(4)-350+20;
    pos(3:4) = [350,350];
    pos(3:4) = [220,220];

    app.HCPPlotFig = figure( ...
        'Position',pos, ...
        'Name','Orientation', ...
        'NumberTitle','off', ...
        'Color',[1,1,1]);
    % 'CloseRequestFcn',''
%         'ToolBar','none', ...
%         'MenuBar','none', ...
    pro = -0.1;
    app.HCPPlotAxe = axes(app.HCPPlotFig, ...
        'Position',[-pro,-pro,1+2*pro,1+2*pro], ...
        'Box','off', ...
        'Color',[1,1,1]);


%     app.HCPPlotAxe.XAxis.Visible = 'off';
%     app.HCPPlotAxe.YAxis.Visible = 'off';
%     app.HCPPlotAxe.ZAxis.Visible = 'off';
    axis(app.HCPPlotAxe,'equal');
    hold(app.HCPPlotAxe,'on');
    app.HCPPlotFig.CloseRequestFcn ={@HCPdemoCloseRequestFcn,app};
else
    menu.Checked = 'off';
    delete(app.HCPPlotFig);
    app.HCPPlotFlag = 0;
    if ~app.SliTraFlag
        app.FreezeButton.Enable = 'off';
    end
end