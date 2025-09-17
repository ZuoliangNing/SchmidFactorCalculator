function IPFscatCloseRequestFcn(fig,~,app)
app.OpenMenu.Checked = 'off';
app.IPFscatFlag = 0;
delete(fig);