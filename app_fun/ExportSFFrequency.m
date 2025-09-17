function ExportSFFrequency(~,~,app)
if isempty(app.test)
    uialert(app.SchmidtfactorcalculatorUIFigure, ...
        'Data does not exist','No Data');
    return
end
A = app.test;
lis = {A.DisplayName};
ind = listdlg('ListString',lis);
if isempty(ind); return; end
A = A(ind);
N = length(A);
path = app.ExpDatDefDir;
dlg = uiprogressdlg(app.SchmidtfactorcalculatorUIFigure, ...
    'Title','Export SF Frequency');
m = [A.SelectedCategoryNumber];
m1 = sum(m);
arrayfun(@fun,A,1:N);
function fun(a,n)
file = [path,a.DisplayName,'-SFfrequency','.xlsx'];
arrayfun(@fun1,1:a.SelectedCategoryNumber);
writecell(a.Info',file, ...
    'Sheet','Info', ...
    'Range','A1');
function fun1(z)
dlg.Value = (sum(m(1:n-1))+z-1)/m1;
dlg.Message = ['Exporting ',a.DisplayName, ...
    ' (',a.SelectedCategoryNames{z},')'];
M = [a.SchmidtFactorsFrequencyEdges{z}(1:end-1), ...
        a.SchmidtFactorsFrequency{z}];
title = {'SF value','Frequency'};
writecell(title,file, ...
    'Sheet',a.SelectedCategoryNames{z}, ...
    'Range','A1');
writematrix(M,file, ...
    'Sheet',a.SelectedCategoryNames{z}, ...
    'Range','A2');
end
end
end