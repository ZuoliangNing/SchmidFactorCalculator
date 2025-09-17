function TreeActions(~,event,app)
node = event.SelectedNodes;
PlotFlag = 0;
app.PloTyp = 0;
app.QueryButton.Enable = 'off';
if isa(node.Parent,'matlab.ui.container.Tree')
    % a root node is selected
    num = node.NodeData;
    fun = @(a) (num == a.No);
    ind = arrayfun(fun, app.test); % number in app.test list
    app.DeleteButton.Enable = 'on';
    app.GBButton.Enable = 'on';
elseif isa(node.Parent.Parent,'matlab.ui.container.Tree')
    % 'Schmidt factors' or 'Schmidt factors frequency' 
    % or 'IPF' is selected
    app.DeleteButton.Enable = 'off';
    app.GBButton.Enable = 'off';
    num = node.Parent.NodeData;
    fun = @(a) (num == a.No);
    ind = arrayfun(fun, app.test); % number in app.test list
else
    % deformation mode is selected
    app.DeleteButton.Enable = 'off';
    app.GBButton.Enable = 'off';
    num = node.Parent.Parent.NodeData;
    switch node.Parent.Text
        case 'Schmidt factors'
            PlotFlag = 1;
        case 'Schmidt factors frequency'
            PlotFlag = 2;
        case 'IPF'
            PlotFlag = 3;
        case 'Grain boundary'
            PlotFlag = 4;
            app.DeleteButton.Enable = 'on';
    end
    fun = @(a) (num == a.No);
    ind = arrayfun(fun, app.test); % number in app.test list
end

app.TextArea.Value = app.test(ind).Info;
if PlotFlag
    n = node.NodeData;
    app.PloNo = find(ind);
    app.CatNo = n;
    switch PlotFlag   
        case 1
            % plot SF
            flag = find(flip(strcmp(node.Text,{app.DeformationsystemsselectionMenu.Children.Text})))<6;
            app.test(ind) = app.test(ind).PlotSF(n,app,flag);
            app.QueryButton.Enable = 'on';
            app.PloTyp = 1;
        case 2
            % plot SF frequency
            app.test(ind) = app.test(ind).PlotSFFrequency(n,app);
            app.PloTyp = 2;
        case 3
            % plot IPF
            app.test(ind) = app.test(ind).PlotIPF(n,app);
            app.PloTyp = 3;
        case 4
            % plot GB
            app.PloTyp = 4;
    end
end
% assign Slip Trace table title
if app.SliTraFlag
    switch PlotFlag
        case 1
           app.SliTraTable.RowName = {'SF','normalized SF'};
           varnam = arrayfun(@(i) ['Var',num2str(i)], ...
                1:app.test(1).DeformationSystemsNumberList( ...
                app.test(app.PloNo).CalculateList(app.CatNo)), ...
                'UniformOutput',false);
           app.SliTraTable.ColumnName = varnam;
        case 3
            app.SliTraTable.RowName = {'SF','normalized SF'};
            nam = {app.test(app.PloNo).CategoryListNodes1.Text};
            app.SliTraTable.ColumnName = nam;
        otherwise
            app.SliTraTable.RowName = '';
            app.SliTraTable.ColumnName = '';
    end
end