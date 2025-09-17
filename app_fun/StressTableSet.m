function StressTableSet(app)
wid = app.UITable.Position(3)-50;
app.UITable.ColumnName = {'x';'y';'z'};
app.UITable.ColumnEditable = [true true true];
app.UITable.RowName = {'X';'Y';'Z'};
app.UITable.ColumnFormat = {'numeric','numeric','numeric'};
app.UITable.Data = app.StrSta;
app.UITable.ColumnWidth = {wid/3,wid/3,wid/3};
app.UITable.CellEditCallback = {@UITableCellEditCallback,app};