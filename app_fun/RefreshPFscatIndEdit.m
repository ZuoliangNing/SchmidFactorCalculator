function RefreshPFscatIndEdit(app)
for i = 1:12
    app.PFscatUic.Edit(i).String = ...
        num2str(app.PFscatInd(i));
end
app.PFscatInd = reshape(str2double({app.PFscatUic.Edit.String}),3,4);

