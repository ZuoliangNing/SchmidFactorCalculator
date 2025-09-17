function displayGrainBoundaryPlot(menu,~,app)
obj = app.test(app.PloNo);
GrainBoundaryPlotNum = menu.Parent.UserData.GrainBoundaryPlotNum;
GBLine = obj.GrainBoundaryPlot{GrainBoundaryPlotNum};
switch menu.Text
    case 'hide'
        GBLine.Visible = 'off';
        menu.Text = 'show';
    case 'show'
        GBLine.Visible = 'on';
        menu.Text = 'hide';
end