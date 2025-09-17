function RefreshQueryTable(app)

temp = app.test(app.PloNo).QueryValue( :,app.CatNo);
ind = arrayfun(@(i) ~isempty(temp(i)),1:length(temp));
allval = temp(ind);
% allval = app.test(app.PloNo).QueryValue( ...
%     1:app.test(app.PloNo).QueryNum(app.CatNo),app.CatNo);
app.UITable2.RowName = arrayfun(@(i) ['P',num2str(i)], ...
                            1:length(allval),'UniformOutput',false);
loc = cell2mat({allval.loc}');
ang = cell2mat({allval.Angle}');
SFs = cell2mat({allval.SFs}');
maxSF = cell2mat({allval.maxSF}');
app.UITable2.Data = [maxSF,SFs,loc,ang];