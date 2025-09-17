function QueryButtonValueChangedFcn(button,~,app)
value = button.Value;
if value
    app.SchmidtfactorcalculatorUIFigure.WindowButtonDownFcn ...
                   = {@UIFigureButtonDownFcn,app};
    app.PreTab = app.TabGroup.SelectedTab;
    app.TabGroup.SelectedTab = app.QueryTab;
    app.Tree.Enable = 'off';
    app.FilesMenu.Enable = 'off';
    app.CalculatesettingMenu.Enable = 'off';
    app.FilesettingMenu.Enable = 'off';
    app.StressMenu.Enable = 'off';
    app.OthersMenu_2.Enable = 'off';
    app.DeleteButton.Text = 'Add';
    app.DeleteButton.Enable = 'on';
    varnam = arrayfun(@(i) ['Var',num2str(i)], ...
        1:app.test(1).DeformationSystemsNumberList( ...
        app.test(app.PloNo).CalculateList(app.CatNo)), ...
        'UniformOutput',false);
    
    app.UITable2.ColumnName = ['maxSF',varnam,'X','Y','A1','B','A2'];
    RefreshQueryTable(app)
    
    
else
    if ishandle(app.TemSca)
        delete(app.TemSca);
        delete(app.TemLab);
    end
    app.DeleteButton.Text = 'Delete';
    app.DeleteButton.Enable = 'off';
    app.Tree.Enable = 'on';
    app.FilesMenu.Enable = 'on';
    app.CalculatesettingMenu.Enable = 'on';
    app.FilesettingMenu.Enable = 'on';
    app.StressMenu.Enable = 'on';
    app.OthersMenu_2.Enable = 'on';
    app.TabGroup.SelectedTab = app.PreTab;
    app.SchmidtfactorcalculatorUIFigure.WindowButtonDownFcn = '';
    
    app.UITable2.ColumnName = [];
    app.UITable2.Data = [];
    
    
end
