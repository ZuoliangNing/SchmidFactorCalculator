function PFscatCheckboxCallback(checkbox,event,app)
i = checkbox.UserData;
if checkbox.Value
    app.PFscatOpt(i) = 1;
else
    app.PFscatOpt(i) = 0;
end