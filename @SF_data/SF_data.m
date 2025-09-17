classdef SF_data
   properties
       DisplayName
       ConvertMethod % from four index to three index
            % OIM / CHANNEL5
       AxialRatio
       CrystalType
       SymmertryMatrix
       AngleUnit % rad / degree
       ColumnList % list of coordinates & Eulerian angle
       StressStateSample % Cauchy stress tensor (normalized)
       CalculateMethod 
            % GSF / 
       CalculateList
   end
   properties 
       X,Y
       uniX ,uniY
       EulerAngles
       ImageQuality
       N
       CalFlag
       AllSurfaceNormals
       AllDirections
       DeformationSystemsNumberList
       SelectedSurfaceNormal3Crystal
       SelectedDirection3Crystal
       SelectedCategoryNumber
       SelectedCategoryColumnInd
       SelectedSystemsNumber
       SlipSystemsNumber
       SelectedSurfaceNormal4Crystal
       SelectedSurfaceNormal3Sample
       SelectedDirection4Crystal
       SelectedDirection3Sample
       InvertTransferMatrix
       CauchyStressVectorsSample
       SchmidtFactors
       SchmidtFactorsMatrix
       MaximumSchmidtFactors
       MaximumSchmidtFactorsIndex uint16
       MaximumSchmidtFactorsMatrix
       SchmidtFactorsFrequency
       SchmidtFactorsFrequencyEdges
       XYUniqueIC uint16
       %
       BasalSlipSurfaceNormal = ...
          [0,0,0,1;%basal plain 3
           0,0,0,1;
           0,0,0,1];
       PrismaticSlipSurfaceNormal = ...
          [1,0,-1,0;%prismatic plain 3
           0,1,-1,0;
           1,-1,0,0];
       Pyramidal1SlipSurfaceNormal = ...
          [1,0,-1,1;%Pyramidal <a> 6
           0,1,-1,1;
           -1,1,0,1;
           -1,0,1,1;
           0,-1,1,1;
           1,-1,0,1];
       Pyramidal2SlipSurfaceNormal = ...
          [1,0,-1,1;%Pyramidal <a+c> 12
           1,0,-1,1;
           0,1,-1,1;
           0,1,-1,1;
           -1,1,0,1;
           -1,1,0,1;
           -1,0,1,1;
           -1,0,1,1;
           0,-1,1,1;
           0,-1,1,1;
           1,-1,0,1;
           1,-1,0,1];
       Pyramidal3SlipSurfaceNormal = ...
          [1,1,-2,2;%Pyramidal <a+c> 6
           -1,2,-1,2;
           -2,1,1,2;
           -1,-1,2,2;
           1,-2,1,2;
           2,-1,-1,2 ];
       TensionTwinning1SurfaceNormal = ...
          [1,0,-1,2;%T1 6
           0,1,-1,2;
           -1,1,0,2;
           -1,0,1,2;
           0,-1,1,2;
           1,-1,0,2];
       TensionTwinning2SurfaceNormal = ...
          [1,1,-2,1;%T2 6
           -1,2,-1,1;
           -2,1,1,1;
           -1,-1,2,1;
           1,-2,1,1;
           2,-1,-1,1];
       CompressionTwinning1SurfaceNormal = ...
          [1,1,-2,2;%C1 6
           -1,2,-1,2;
           -2,1,1,2;
           -1,-1,2,2;
           1,-2,1,2;
           2,-1,-1,2];
       CompressionTwinning2SurfaceNormal = ...
          [1,0,-1,1;%C2 6
           0,1,-1,1;
           -1,1,0,1;
           -1,0,1,1;
           0,-1,1,1;
           1,-1,0,1];
       BasalSlipDirection = ...
          [1,1,-2,0;%basal plain 3
           -2,1,1,0;
           1,-2,1,0];
       PrismaticSlipDirection = ...
          [1,-2,1,0;%prismatic plain 3
           -2,1,1,0;
           1,1,-2,0];
       Pyramidal1SlipDirection = ...
          [1,-2,1,0;%Pyramidal <a> 6
           -2,1,1,0;
           1,1,-2,0;
           1,-2,1,0;
           -2,1,1,0;
           1,1,-2,0];
       Pyramidal2SlipDirection = ...
          [-1,-1,2,3;%Pyramidal <a+c> 12 
           -2,1,1,3;
           1,-2,1,3;
           -1,-1,2,3;
           2,-1,-1,3;
           1,-2,1,3;
           1,1,-2,3;
           2,-1,-1,3;
           -1,2,-1,3;
           1,1,-2,3;
           -2,1,1,3;
           -1,2,1,3];
       Pyramidal3SlipDirection = ...
          [-1,-1,2,3;%Pyramidal <a+c> 6
           1,-2,1,3;
           2,-1,-1,3;
           1,1,-2,3;
           -1,2,-1,3;
           -2,1,1,3];
       TensionTwinning1Direction = ...
          [-1,0,1,1;%T1 6
           0,-1,1,1;
           1,-1,0,1;
           1,0,-1,1;
           0,1,-1,1;
           -1,1,0,1];
       TensionTwinning2Direction = ...
          [-1,-1,2,6;%T2 6
           1,-2,1,6;
           2,-1,-1,6;
           1,1,-2,6;
           -1,2,-1,6;
           -2,1,1,6];
       CompressionTwinning1Direction = ...
          [1,1,-2,-3;%C1 6
           -1,2,-1,-3;
           -2,1,1,-3;
           -1,-1,2,-3;
           1,-2,1,-3;
           2,-1,-1,-3];
       CompressionTwinning2Direction = ...
          [1,0,-1,-2;%C2 6
           0,1,-1,-2;
           -1,1,0,-2;
           -1,0,1,-2;
           0,-1,1,-2;
           1,-1,0,-2];
       
   end
   methods
       function a = SF_data( path,file, ...
               ConvertMethod,CrystalType,AxialRatio,AngleUnit, ...
               ColumnList,StressState,CalculateMethod, ...
               CalculateList)
           dir = cd; cd(path); 
           Data = readmatrix(file);
           Data = Data(~isnan(Data(:,1)),:);
           Data = Data(:,~isnan(Data(1,:)));
           cd(dir);
           a.ConvertMethod = ConvertMethod;
           a.AxialRatio = AxialRatio;
           a.CrystalType = CrystalType;
           a.SymmertryMatrix = getSymmetryMatrix(CrystalType);
           a.AngleUnit = AngleUnit;
           a.ColumnList = ColumnList;
%            a.StressStateSample = StressState/max(abs(StressState(:)));
           a.StressStateSample = StressState;
           a.CalculateMethod = CalculateMethod;
           a.CalculateList = CalculateList;
           temp = strsplit(file,'.');
           a.DisplayName = temp{1};
           a.AllSurfaceNormals = ...
               { a.BasalSlipSurfaceNormal;
                 a.PrismaticSlipSurfaceNormal;
                 a.Pyramidal1SlipSurfaceNormal;
                 a.Pyramidal2SlipSurfaceNormal;
                 a.Pyramidal3SlipSurfaceNormal;
                 a.TensionTwinning1SurfaceNormal;
                 a.TensionTwinning2SurfaceNormal;
                 a.CompressionTwinning1SurfaceNormal;
                 a.CompressionTwinning2SurfaceNormal};
           a.AllDirections = ...
               { a.BasalSlipDirection;
                 a.PrismaticSlipDirection;
                 a.Pyramidal1SlipDirection;
                 a.Pyramidal2SlipDirection;
                 a.Pyramidal3SlipDirection;
                 a.TensionTwinning1Direction;
                 a.TensionTwinning2Direction;
                 a.CompressionTwinning1Direction;
                 a.CompressionTwinning2Direction};
           a.DeformationSystemsNumberList = [3,3,6,12,6,6,6,6,6];
           a.SlipSystemsNumber = sum( ...
               a.DeformationSystemsNumberList( ...
                    a.CalculateList(a.CalculateList< 6 )));
           a.SelectedSurfaceNormal4Crystal = ...
               cell2mat(a.AllSurfaceNormals(a.CalculateList))';
           a.SelectedSurfaceNormal3Crystal = ...
               SurfaceNormalIndexConvert( ...
               a.SelectedSurfaceNormal4Crystal', ...
               a.AxialRatio,a.ConvertMethod);
           a.SelectedDirection4Crystal = ...
               cell2mat(a.AllDirections(a.CalculateList))';
           a.SelectedDirection3Crystal = ...
               DirectionIndexConvert( ...
               a.SelectedDirection4Crystal', ...
               a.AxialRatio,a.ConvertMethod);
           a.SelectedCategoryNumber = size(a.CalculateList,2);
           a.SelectedSystemsNumber = ...
               size(a.SelectedSurfaceNormal3Crystal,2);
           a.N = size(Data,1);
           a.X = Data(:,a.ColumnList(1));
           a.Y = Data(:,a.ColumnList(2));
           a.EulerAngles = Data(:,a.ColumnList(3:5));
%            a.ImageQuality = Data(:,6);
            clear Data
           if strcmp(a.AngleUnit,'degree')
              a.EulerAngles = a.EulerAngles/180*pi; 
           end
           a.InvertTransferMatrix = ...
               EulerAngle2InvertTransferMatrix(a.EulerAngles);
           temp = repmat(a.SelectedSurfaceNormal3Crystal,a.N,1); % (3n*m)
           a.SelectedSurfaceNormal3Sample = ...
               Index3Convert2Sample(a.InvertTransferMatrix,temp);
           temp = repmat(a.SelectedDirection3Crystal,a.N,1); % (3n*m)
           a.SelectedDirection3Sample = ...
               Index3Convert2Sample(a.InvertTransferMatrix,temp);
           clear temp
           a.CauchyStressVectorsSample = ...
               a.StressStateSample * a.SelectedSurfaceNormal3Sample;
           switch a.CalculateMethod
               case 'GSF'
                   a.SchmidtFactors = sum( ...
                       a.CauchyStressVectorsSample ...
                       .* a.SelectedDirection3Sample ,1);
               case 'CP'
                   a.SchmidtFactors = sum( ...
                       a.CauchyStressVectorsSample ...
                       .* a.SelectedDirection3Sample) ...
                       .* sum( ...
                       a.CauchyStressVectorsSample ...
                       .* a.SelectedSurfaceNormal3Sample) ...
                       ./ vecnorm(a.CauchyStressVectorsSample,2,1).^2;
               case 'Modified GSF'
                   temp = a.StressStateSample - eye(3)*sum(diag(a.StressStateSample))/3;
                   sigma_bar = sqrt(3/2*trace(temp*temp'));
                   a.SchmidtFactors = sum( ...
                       a.CauchyStressVectorsSample ...
                       .* a.SelectedDirection3Sample ,1)/sigma_bar;
                   
           end
           a.SchmidtFactors = ...
               reshape(a.SchmidtFactors,[a.N,a.SelectedSystemsNumber]);
           a.SchmidtFactors(:,1:a.SlipSystemsNumber) = ...
               abs(a.SchmidtFactors(:,1:a.SlipSystemsNumber));
           ind = cell(1,a.SelectedCategoryNumber);
           ind{1} = 1:a.DeformationSystemsNumberList(a.CalculateList(1));
           for i =2:a.SelectedCategoryNumber
               val = sum(a.DeformationSystemsNumberList(a.CalculateList(1:i)));
               ind{i} = 1+ind{i-1}(end) : val;
           end
           a.SelectedCategoryColumnInd = ind;
           [temp1,temp2] = ...
               cellfun(@(z)max(a.SchmidtFactors(:,z),[],2), ...
               ind,'UniformOutput',false);
           a.MaximumSchmidtFactors = cell2mat(temp1);
           a.MaximumSchmidtFactorsIndex = cell2mat(temp2);
           a.SchmidtFactorsFrequencyEdges = ...
               arrayfun(@(i) ...
               [min(0,min(a.MaximumSchmidtFactors(:,i))); ...
                    (0.01:0.01:max(0.5,max(a.MaximumSchmidtFactors(:,i))))'], ...
                    1:a.SelectedCategoryNumber, ...
                    'UniformOutput',false);
           a.SchmidtFactorsFrequency = ...
               arrayfun(@(i) ...
               (histcounts(a.MaximumSchmidtFactors(:,i), ...
               a.SchmidtFactorsFrequencyEdges{i}, ...
               'Normalization', 'probability'))', ...
               1:a.SelectedCategoryNumber, ...
               'UniformOutput',false);
           clear ind
           [a.uniX,~,ind(:,1)] = unique(a.X);
           [a.uniY,~,ind(:,2)] = unique(a.Y);
           a.XYUniqueIC = ind;
%            a.SchmidtFactorsMatrix = ...
%                ReshapeSchmidtFactorsMatrix(ind,a.SchmidtFactors);
           a.MaximumSchmidtFactorsMatrix = ...
               ReshapeSchmidtFactorsMatrix(ind,a.MaximumSchmidtFactors);
           % release RAM
           a.SelectedSurfaceNormal3Sample = [];
           a.SelectedDirection3Sample = [];
%            a.InvertTransferMatrix = []; % used for IPF
           a.CauchyStressVectorsSample = [];
       end
   end
end