function IPFlegendCloseRequestFcn(fig,~,app)
app.IPFlegendMenu.Checked = 'off';
delete(fig);