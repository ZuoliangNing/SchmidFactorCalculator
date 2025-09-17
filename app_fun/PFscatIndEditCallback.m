function PFscatIndEditCallback(Edit,event,app)
val = str2double(Edit.String);
ind = Edit.UserData; % column / row
if rem(val,1)
   warndlg('Wrong Miller Index !','input Miller Index','modal');
   Edit.String = num2str(app.PFscatInd(ind(1),ind(2)));
   return
end
app.PFscatInd(ind(2),ind(1)) = val;
app.PFscatInd(ind(2),3) = -sum(app.PFscatInd(ind(2),1:2));
RefreshPFscatIndEdit(app);


