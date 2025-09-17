function IPFlegendMenuSelected(menu,~,app)
if strcmp(menu.Checked, 'off')
   menu.Checked = 'on';
   pos = app.SchmidtfactorcalculatorUIFigure.Position;
   siz = [240,160];
   pos(1) = pos(1) + pos(3) - siz(1);
   pos(2) = pos(2) - siz(2) - 35;
   pos(3:4) = siz;
   app.IPFlegendFig = figure( ...
       'Position',pos, ...
        'Name','IPF legend', ...
        'NumberTitle','off', ...
        'Resize','off', ...
        'Color',[1,1,1]);
    %        'ToolBar','none', ...
%         'MenuBar','none', ...
    app.IPFlegendFig.CloseRequestFcn = ...
        {@IPFlegendCloseRequestFcn,app};
    pro = -0.2;
    app.IPFlegendAxe = axes(app.IPFlegendFig, ...
        'Position',[-pro,-pro,1+2*pro,1+2*pro], ...
        'Box','off', ...
        'Color',[1,1,1]);
    hold on
    C = getIPFlegendCData;
    image(app.IPFlegendAxe,[0,1],[0,0.5],C);
    app.IPFlegendAxe.YDir = 'normal';
    axis(app.IPFlegendAxe,'equal');
    theta = 0:0.02:pi/6;
    rho = ones(1,length(theta));
    [x,y] = pol2cart(theta,rho);
    plot(app.IPFlegendAxe,[0,x,0],[0,y,0], ...
    'Color','black','LineWidth',1);
    app.IPFlegendAxe.XAxis.Visible = 'off';
    app.IPFlegendAxe.YAxis.Visible = 'off';
    txt1 = text(app.IPFlegendAxe);
    txt1.Position = [-0.1,-0.1];
    txt1.String = '0001';
    txt2 = text(app.IPFlegendAxe);
    txt2.Position = [1-0.1,-0.1];
    txt2.String = '2-1-10';
    txt3 = text(app.IPFlegendAxe);
    txt3.Position = [0.766,0.6];
    txt3.String = '10-10';
else
    menu.Checked = 'off';
    delete(app.IPFlegendFig);
end