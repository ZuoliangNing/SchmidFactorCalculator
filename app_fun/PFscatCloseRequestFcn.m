function PFscatCloseRequestFcn(fig,~,app)
app.PFscatterMenu.Checked = 'off';
app.PFscatFlag = 0;
delete(fig);