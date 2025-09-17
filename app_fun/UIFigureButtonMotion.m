function UIFigureButtonMotion(~,~,app)
if app.HCPPlotFlag
% Plot HCP
PlotHCP(app);
end
% Slip Trace
if app.SliTraFlag 
PlotSlipTrace(app);
end
% PF scatter
if app.PFscatFlag
PlotPFscatter(app);
end
if app.IPFscatFlag
PlotIPFscatter(app);
end

