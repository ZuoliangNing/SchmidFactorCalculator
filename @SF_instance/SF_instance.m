classdef SF_instance < SF_data
   properties
      Axe
      Plot
      No
      Node
      SchmidtFactorsNode
        CategoryListNodes1
      SchmidtFactorsFrequencyNode
        CategoryListNodes2
      IPFNode
        IPFCategoryNodes
      GrainBoundaryMainNode
        GrainBoundaryNode
        
      Info
      SelectedCategoryNames
      QueryScatter
      QueryNum
      QueryText
      QueryValue
      IPF
      GrainBoundaryPlotNum
      GrainBoundaryData
      GrainBoundaryPlot
      GrainBoundaryCalculateFlag
   end
   methods
       function a = SF_instance( path,file,app )

           a = a@SF_data(path,file, ...
               app.ConMet,app.CryTyp,app.AxiRat,app.AngUni, ...
               app.ColLis,app.StrSta,app.CalMet, ...
               app.CalLis);
           a.Axe = app.UIAxes;
           a.No = app.Num;
           a.Node = uitreenode(app.Tree, ...
               'Text',a.DisplayName, ...
               'NodeData',a.No);
           a.SchmidtFactorsNode = uitreenode(a.Node, ...
               'Text','Schmidt factors');
           a.SchmidtFactorsFrequencyNode = uitreenode(a.Node, ...
               'Text','Schmidt factors frequency');
           name = flip({app.DeformationsystemsselectionMenu.Children.Text});
           name = name(a.CalculateList);
           a.SelectedCategoryNames = name;
           a.CategoryListNodes1 = arrayfun(@(i) uitreenode(...
               a.SchmidtFactorsNode, ...
               'Text',name{i}, ...
               'NodeData',i), ...
               1:a.SelectedCategoryNumber);
           a.CategoryListNodes2 = arrayfun(@(i) uitreenode(...
               a.SchmidtFactorsFrequencyNode, ...
               'Text',name{i}, ...
               'NodeData',i), ...
               1:a.SelectedCategoryNumber);
           str = num2str(a.StressStateSample);
           a.Info = {['Name : ',a.DisplayName], ...
                     ['Points : ',num2str(a.N)], ...
                     ['Convert method : ',a.ConvertMethod], ...
                     ['Axial ratio : ',num2str(a.AxialRatio)], ...
                     ['Angle unit : ',a.AngleUnit], ...
                     ['xy columns : from ',num2str(a.ColumnList(1)),' to ', ...
                     num2str(a.ColumnList(2))], ...
                     ['Euler angles columns : from ', ...
                     num2str(a.ColumnList(3)),' to ', ...
                     num2str(a.ColumnList(5))] ...
                     'Stress State :',str(1,:),str(2,:),str(3,:), ...
                     ['Calculate method : ',a.CalculateMethod]};
             a.QueryNum = zeros(1,a.SelectedCategoryNumber);
             a.QueryScatter = cell(1,a.SelectedCategoryNumber);
             [a.QueryScatter{:}] = deal(matlab.graphics.chart.primitive.Scatter);
             a.QueryText = cell(1,a.SelectedCategoryNumber);
             [a.QueryText{:}] = deal(matlab.ui.control.Label);
             a.Plot = cell(1,a.SelectedCategoryNumber);
             function SetPlot(n)
                 a.Plot{n} = matlab.graphics.primitive.Image;
                 a.Plot{n}.XData = a.uniX;
                 a.Plot{n}.YData = a.uniY;
                 a.Plot{n}.CData = a.MaximumSchmidtFactorsMatrix(:,:,n)';
                 a.Plot{n}.CDataMapping = 'scaled';
                 a.Plot{n}.Parent = app.UIAxes;
                 a.Plot{n}.Visible = 'off';
             end
             arrayfun(@SetPlot,1:a.SelectedCategoryNumber);
             a.MaximumSchmidtFactorsMatrix = [];
             a.QueryValue = repmat(struct('loc',[], ...
                          'Angle',[], ...
                          'SFs',[], ...
                          'maxSF',[]), ...
                          1,a.SelectedCategoryNumber);
              a.IPF = cell(1,3);
              a = a.CalculateIPF(app);
              a.IPFNode = uitreenode(a.Node, ...
                  'Text','IPF');
              name = {'X','Y','Z'};
              a.IPFCategoryNodes = arrayfun(@(i) uitreenode(...
                  a.IPFNode, ...
                  'Text',name{i}, ...
                  'NodeData',i), ...
                  1:3);
              a.IPFNode.expand
              a = a.PlotIPF(1,app);
              a.GrainBoundaryCalculateFlag = 0;
              a.GrainBoundaryPlotNum = 0;
              a.GrainBoundaryPlot = {};
              a.GrainBoundaryCalculateFlag = 0;
              a.GrainBoundaryMainNode = [];
              a.GrainBoundaryNode = [];
           end
       a = PlotSF(a,n,app,flag)
       a = PlotSFFrequency(a,n,app)
       a = PlotIPF(a,n,app)
       a = CalculateGrainBoundary(a,app,par)
       a = PlotGrainBoundary(a,n,app)
       Delete(a,app)
   end
end

