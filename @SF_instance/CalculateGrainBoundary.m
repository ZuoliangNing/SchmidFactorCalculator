function obj = CalculateGrainBoundary(obj,app,par)

threshold = par.Limit;
Color = par.Color;
LineWidth = par.LineWidth;

if ~obj.GrainBoundaryCalculateFlag
    PolygonEdgeRange = 3:20;
    [sx,lx] = bounds(obj.X);
    [sy,ly] = bounds(obj.Y);
    d = (obj.X(2)-obj.X(1))*2;
    [Vertexes,Cells] = voronoin(append_xy(obj.X,obj.Y,d));
    N = [size(Vertexes,1),size(Cells,1)];
    SortedCells = arrayfun(@(i) zeros(N(1),i+1), ...
        PolygonEdgeRange, ...
        'UniformOutput',false);
    SortedCellsNumber = zeros(length(SortedCells),1);
    VoronoiNumber = 0;
    SeedsOriginalIndex = zeros(N(2),1);
    dev = d/10*1.1;
    box = [sx-dev,lx+dev,sy-dev,ly+dev];
    for i = 1:N(2)
        VertexList = Cells{i};
        if VoronoiPositionCheck(...
                Vertexes(VertexList,1),Vertexes(VertexList,2),box)
            VoronoiNumber = VoronoiNumber +1 ;
            SeedsOriginalIndex(VoronoiNumber) = i ;
            % check CCW
            Vector = diff(Vertexes(VertexList(1:3),:));
            Area = cross([Vector(1,:),0],[Vector(2,:),0]);
            if Area(3) < 0 ; VertexList = flip(VertexList); end
            SortIndex = length(VertexList) - PolygonEdgeRange(1) +1;
            SortedCellsNumber(SortIndex) = SortedCellsNumber(SortIndex) +1;
            SortedCells{SortIndex}(SortedCellsNumber(SortIndex),:) = ...
                [VertexList,VoronoiNumber];
        end  
    end
    SeedsOriginalIndex = SeedsOriginalIndex(1:VoronoiNumber);
    temp = SortedCellsNumber~=0;
    SortedCells = SortedCells(temp);
    SortedCellsNumber = SortedCellsNumber(temp);
    SortedCells = arrayfun(@(i)SortedCells{i}(1:SortedCellsNumber(i),:), ...
                        1:length(SortedCellsNumber),'UniformOutput',false);
    PolygonEdgeRange = PolygonEdgeRange(temp);
    T = sparse(N(1),N(1));
    for i = 1:length(SortedCells)
        T = T + ...
          sparse( ...
              SortedCells{i}(:,1:end-1), ...
              SortedCells{i}(:,[end-1,1:end-2]), ...
              repmat(SortedCells{i}(:,end),1,PolygonEdgeRange(i)), ...
              N(1),N(1));
    end
    E = (T & T').* T ;
    [EdgesVertex1,EdgesVertex2,ConnectedCells1] = find(triu(E));
    ConnectedCellsNumber = length(ConnectedCells1);
    [~,~,ConnectedCells2] = find(triu(E'));
    M = zeros(ConnectedCellsNumber,1);
    D = obj.SymmertryMatrix;
    
    InvertTransferMatrix = obj.InvertTransferMatrix';
    tempn = size(InvertTransferMatrix,2)/3;
    InvertTransferMatrix = reshape(InvertTransferMatrix,[3,3,tempn]);
    temp1 = SeedsOriginalIndex(ConnectedCells1(1:ConnectedCellsNumber));
    temp2 = SeedsOriginalIndex(ConnectedCells2(1:ConnectedCellsNumber));
    temp3 = InvertTransferMatrix(:,:,temp1);
    temp4 = InvertTransferMatrix(:,:,temp2);
    
    
    parfor i = 1:ConnectedCellsNumber
        G1 =  temp3(:,:,i); % sam -> cry
        G2 =  temp4(:,:,i);
        dG = G2'*G1*D;
        x = ( sum([dG(1:9:end);dG(5:9:end);dG(9:9:end)]) - 1 ) / 2 ;
        theta = acos( x );
        theta = min(theta);
        M(i) = theta;
    end
    
    obj.GrainBoundaryMainNode = uitreenode(obj.Node,'Text','Grain boundary');
    
    obj.GrainBoundaryData.Vertexes = Vertexes;
    obj.GrainBoundaryData.M = M;
    obj.GrainBoundaryData.EdgesVertex1 = EdgesVertex1;
    obj.GrainBoundaryData.EdgesVertex2 = EdgesVertex2;
    obj.GrainBoundaryCalculateFlag = 1;
end

thresholdrad = deg2rad(threshold);
tempind = obj.GrainBoundaryData.M>thresholdrad(1) ...
        & obj.GrainBoundaryData.M<thresholdrad(2);
GrainBoundaryEdgesVertex1 = obj.GrainBoundaryData.EdgesVertex1(tempind);
GrainBoundaryEdgesVertex2 = obj.GrainBoundaryData.EdgesVertex2(tempind);
obj.GrainBoundaryPlotNum = obj.GrainBoundaryPlotNum + 1 ;
obj.GrainBoundaryPlot{obj.GrainBoundaryPlotNum} = ...
    showLine(GrainBoundaryEdgesVertex1,GrainBoundaryEdgesVertex2, ...
    obj.GrainBoundaryData.Vertexes,app.UIAxes,Color,LineWidth);

node = uitreenode(...
    obj.GrainBoundaryMainNode, ...
    'Text',[num2str(threshold(1)),' - ',num2str(threshold(2))]);
node.NodeData.GrainBoundaryPlotNum = obj.GrainBoundaryPlotNum;
cm = uicontextmenu(app.SchmidtfactorcalculatorUIFigure);
cm.UserData.GrainBoundaryPlotNum = obj.GrainBoundaryPlotNum;
uimenu(cm, ...
      'Text','hide', ...
      'MenuSelectedFcn',{@displayGrainBoundaryPlot,app});

node.ContextMenu = cm;
obj.GrainBoundaryNode = [obj.GrainBoundaryNode,node];

end

function coord = append_xy(x,y,d)
dev = d/10;
[sx,lx] = bounds(x);
[sy,ly] = bounds(y);
ind = x > lx - d;
x = [x;2*(lx + dev) - x(ind)];
y = [y;y(ind)];
ind = x < sx + d;
x = [x;2*(sx - dev) - x(ind)];
y = [y;y(ind)];
ind = y > ly - d;
x = [x;x(ind)];
y = [y;2*(ly + dev) - y(ind)];
ind = y < sy + d;
x = [x;x(ind)];
y = [y;2*(sy - dev) - y(ind)];
coord = [x,y];
end

function flag = VoronoiPositionCheck(vxs,vys,box)
flag = false ;
if all(vxs <= box(2)) && ...
        all(vxs >= box(1)) && ...
        all(vys <= box(4)) && ...
        all(vys >= box(3))
    flag = true ;
end
end

function h = showLine(ind1,ind2,v,axe,color,LineWidth)
temp = nan(length(ind1),1);
x = [v(ind1,1), v(ind2,1),temp]';
y = [v(ind1,2), v(ind2,2),temp]';
x = x(:);
y = y(:);
h = line(axe,x,y, ...
    'Color',color, ...
    'LineWidth',LineWidth);
end