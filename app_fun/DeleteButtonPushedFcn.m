function DeleteButtonPushedFcn(button,~,app)
switch button.Text
    case 'Delete'
        node = app.Tree.SelectedNodes;
        switch app.PloTyp
            case 0
                ind = node.NodeData;
                a = app.test(arrayfun(@(b)(b.No),app.test) == ind);
                Ans = uiconfirm(app.SchmidtfactorcalculatorUIFigure, ...
                    ['Ok to delete ',a.DisplayName,' ?'], ...
                    'Delete Data');
                if ~strcmp(Ans,'È·¶¨') && ~strcmp(Ans,'OK')
                    return
                end
                Delete(a,app);
            case 4
                obj = app.test(app.PloNo);
                GrainBoundaryPlotNum = ...
                    node.NodeData.GrainBoundaryPlotNum;
                delete(obj.GrainBoundaryPlot{GrainBoundaryPlotNum})
                delete(node)
                app.DeleteButton.Enable = 'off';
        end
        
    case 'Add'
        n = app.CatNo;
        pos = app.CurAxePos;
        app.test(app.PloNo).QueryNum(n) = ...
            app.test(app.PloNo).QueryNum(n)+1;
        app.test(app.PloNo). ...
            QueryScatter{app.test(app.PloNo).QueryNum(n),n} = ...
                scatter(app.UIAxes,pos(1),pos(2),5,'r','filled');
        
        app.test(app.PloNo).QueryText{app.test(app.PloNo).QueryNum(n),n} = ...
            uilabel(app.RightPanel, ...
            'Text',['P',num2str(app.test(app.PloNo).QueryNum(n))], ...
            'FontSize',15, ...
            'Position',app.CurPanPos, ...
            'FontColor',[1,0,0]);
        
        a = app.test(app.PloNo);
        pos = app.UIAxes.CurrentPoint(1,1:2);
        dis = vecnorm([a.X-pos(1),a.Y-pos(2)],2,2);
        ind = find(dis==min(dis));
        loc = [a.X(ind),a.Y(ind)];
        Angle = a.EulerAngles(ind,:);
%         data = app.UITable2.Data(end,:);
%         maxSF = data{1};
%         SFs = data{2:1+a.SelectedCategoryColumnInd{n}};
        
        SFs = a.SchmidtFactors(ind,a.SelectedCategoryColumnInd{n});
        maxSF = max(SFs);
        app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n),app.CatNo)...
            .loc = loc;
        app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n),app.CatNo)...
            .Angle = Angle;
        app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n),app.CatNo)...
            .SFs = SFs;
        app.test(app.PloNo).QueryValue(app.test(app.PloNo).QueryNum(n),app.CatNo)...
            .maxSF = maxSF;     
end