function ExportQuery(~,~,app)
if isempty(app.test)
    uialert(app.SchmidtfactorcalculatorUIFigure, ...
        'Data does not exist','No Data');
    return
end
if ~max([app.test.QueryNum])
    uialert(app.SchmidtfactorcalculatorUIFigure, ...
        'Query Data does not exist','No Data');
    return
end
A = app.test;
A = A(arrayfun(@(a) max(a.QueryNum)>0,A));
lis = {A.DisplayName};
ind = listdlg('ListString',lis);
if isempty(ind); return; end
A = A(ind);
path = app.ExpDatDefDir;
arrayfun(@fun,A);
uialert(app.SchmidtfactorcalculatorUIFigure, ...
        'Done','Export Query', ...
        'Icon','success');
function fun(a)
file = [path,a.DisplayName,'-Query','.xlsx'];
arrayfun(@fun1,1:a.SelectedCategoryNumber);
writecell(a.Info',file, ...
    'Sheet','Info', ...
    'Range','A1');
    function fun1(z)
        if ~a.QueryNum(z)
            return
        else
            varnam = arrayfun(@(i) ['Var',num2str(i)], ...
                1:a.DeformationSystemsNumberList(z), ...
                'UniformOutput',false);
            ColumnName = ['maxSF',varnam,'X','Y','A1','B','A2'];
            allval  = a.QueryValue( 1:a.QueryNum(z),z);
            loc = cell2mat({allval.loc}');
            ang = cell2mat({allval.Angle}');
            SFs = cell2mat({allval.SFs}');
            maxSF = cell2mat({allval.maxSF}');
            M = [maxSF,SFs,loc,ang];
            RowName = arrayfun(@(i) ['P',num2str(i)], ...
                            1:a.QueryNum(z),'UniformOutput',false);
            writecell(RowName',file, ...
                'Sheet',a.SelectedCategoryNames{z}, ...
                'Range','A2');
            writecell(ColumnName,file, ...
                'Sheet',a.SelectedCategoryNames{z}, ...
                'Range','B1');
            writematrix(M,file, ...
                'Sheet',a.SelectedCategoryNames{z}, ...
                'Range','B2');
        end 
    end
end
end
