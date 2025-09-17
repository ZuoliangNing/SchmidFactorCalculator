function SlipTraceMenuSelected(menu,~,app)
if strcmp(menu.Checked, 'on')
    menu.Checked = 'off';
    app.FreezeButton.Enable = 'off';
    delete(app.SliTraFig);
    app.SliTraFlag = 0;
    return
end
app.SliTraFlag = 1;
menu.Checked = 'on';
app.FreezeButton.Enable = 'on';
pos = app.SchmidtfactorcalculatorUIFigure.Position;
pos(1) = pos(1)+pos(3)+20;
pos(2) = pos(2);
pos(3:4) = [450,450];
app.SliTraFig = figure( ...
    'Position',pos, ...
    'Name','Slip Trace', ...
    'NumberTitle','off', ...
    'Resize','off');
%     'MenuBar','none' 'ToolBar','none', ...
wid = 15;
wid2 = 80;
wid3 = 50;
app.SliTraAxe = polaraxes(app.SliTraFig, ...
    'Box','on', ...
    'Color',[1,1,1], ...
    'Unit','pixels');
app.SliTraAxe.Position = [wid,wid+wid2+wid3,450-2*wid,450-2*wid-wid2-wid3];
app.SliTraAxe.RAxis.Visible = 'off';
app.SliTraAxe.ThetaAxis.Visible = 'off';
app.SliTraAxe.RGrid = 'off';
app.SliTraAxe.ThetaGrid = 'off';
hold(app.SliTraAxe,'on');
legend;
app.SliTraFig.CloseRequestFcn = {@SliTraFigCloseRequestFcn,app};
app.SliTraTable = uitable(app.SliTraFig);
app.SliTraTable.Position = [wid,wid+wid3,450-2*wid,wid2-5];
% theta = 0:0.01:2*pi+0.01;
% r = ones(1,length(theta));
% polarplot(app.SliTraAxe,theta,r,'LineWidth',1,'Color',[0,0,0]);
app.SliTraAxe.RLim = [0,1];
app.SliTraText = uicontrol('Style','text');
app.SliTraText.Position = [wid,wid,450-2*wid,wid3-wid];
app.SliTraText.FontName = 'Times New Roman';
app.SliTraText.FontSize = 12;
app.SliTraText.HorizontalAlignment = 'left';
node = app.Tree.SelectedNodes;
if ~isempty(node) && ...
        isa(node.Parent.Parent.Parent,'matlab.ui.container.Tree')
    switch node.Parent.Text
        case 'Schmidt factors'
            app.SliTraTable.RowName = {'SF','normalized SF'};
            varnam = arrayfun(@(i) ['Var',num2str(i)], ...
                    1:app.test(1).DeformationSystemsNumberList( ...
                    app.test(app.PloNo).CalculateList(app.CatNo)), ...
                    'UniformOutput',false);
             app.SliTraTable.ColumnName = varnam;
        case 'IPF'
            app.SliTraTable.RowName = {'SF','normalized SF'};
            nam = {app.test(app.PloNo).CategoryListNodes1.Text};
            app.SliTraTable.ColumnName = nam;
    end         
end