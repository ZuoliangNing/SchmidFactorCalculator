function IPFscatDelButtonCallback(~,~,app)
if isempty(app.IPFscatUic.ListBox.String)
    return
end
ListNum = app.IPFscatUic.ListBox.Value;
app.IPFscatUic.ListBox.String(ListNum) = [];
app.IPFscatUic.ListBox.Value = max([app.IPFscatUic.ListBox.Value - 1,1]);
ListNumNew = app.IPFscatUic.ListBox.Value;
try
    temp = app.IPFscatFig.UserData.VecData(ListNumNew,:);
    temp2 = app.IPFscatFig.UserData.VecSampleData(ListNewNum,:);
    prec = 3;
    app.IPFscatUic.Text(1).String = ...
        {ListBox.String{ListNewNum}, ...
        [num2str(temp(1),prec),' ',num2str(temp(2),prec),' ',num2str(temp(3),prec)], ...
        [num2str(temp2(1),prec),' ',num2str(temp2(2),prec),' ',num2str(temp2(3),prec)]};
catch
    app.IPFscatUic.Text(1).String = '';
end

app.IPFscatFig.UserData.VecData(ListNum,:) = [];
app.IPFscatFig.UserData.VecSampleData(ListNum,:) = [];