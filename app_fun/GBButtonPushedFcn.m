function GBButtonPushedFcn(~,~,app)
if ishandle(app.GBFig)
    delete(app.GBFig)
end
pos = app.SchmidtfactorcalculatorUIFigure.Position;
siz = [150,180];
pos(1) = pos(1)+pos(3)/2-siz(1)/2;
pos(2) = pos(2)+pos(4)/2-siz(2)/2;
pos(3:4) = siz;
app.GBFig = uifigure( ...
    'Position',pos, ...
    'Name','Add GB', ...
    'Resize','off');
GridLayout = uigridlayout(app.GBFig, ...
    'RowHeight',{'1x', '1x', '1x', '1x','1x'}, ...
    'ColumnSpacing', 5 ,...
    'RowSpacing',5);
MinLabel = uilabel(GridLayout, ...
    'HorizontalAlignment','right', ...
    'Text','Min / ° :');
MinLabel.Layout.Row = 1;
MinLabel.Layout.Column = 1;
MinSpinner = uispinner(GridLayout, ...
    'Value',app.GBLimit(1));
MinSpinner.Layout.Row = 1;
MinSpinner.Layout.Column = 2;
MaxLabel = uilabel(GridLayout, ...
    'HorizontalAlignment','right', ...
    'Text','Max / ° :');
MaxLabel.Layout.Row = 2;
MaxLabel.Layout.Column = 1;
MaxSpinner = uispinner(GridLayout, ...
    'Value',app.GBLimit(2));
MaxSpinner.Layout.Row = 2;
MaxSpinner.Layout.Column = 2;
ColorButton = uibutton(GridLayout, 'push', ...
    'Text','', ...
    'BackgroundColor','black', ...
    'ButtonPushedFcn',@(button,~)uisetcolor(button));
ColorButton.Layout.Row = 3;
ColorButton.Layout.Column = 2;
ColorLabel = uilabel(GridLayout, ...
    'HorizontalAlignment','right', ...
    'Text','Color :');
ColorLabel.Layout.Row = 3;
ColorLabel.Layout.Column = 1;

WidthLabel = uilabel(GridLayout, ...
    'HorizontalAlignment','right', ...
    'Text','Width :');
WidthLabel.Layout.Row = 4;
WidthLabel.Layout.Column = 1;

WidthEditField = uieditfield(GridLayout, 'numeric', ...
    'Value',1);
WidthEditField.Layout.Row = 4;
WidthEditField.Layout.Column = 2;

ConfirmButton = uibutton(GridLayout, 'push', ...
    'Text','Confirm', ...
    'ButtonPushedFcn',@ConfirmButtonPushedFcn);
ConfirmButton.Layout.Row = 5;
ConfirmButton.Layout.Column = 2;
CancelButton = uibutton(GridLayout, 'push', ...
    'Text','Cancel', ...
    'ButtonPushedFcn',@CancelButtonPushedFcn);
CancelButton.Layout.Row = 5;
CancelButton.Layout.Column = 1;

function ConfirmButtonPushedFcn(~,~)
    par.Limit = [MinSpinner.Value,MaxSpinner.Value];
    app.GBLimit = par.Limit;
    par.Color = ColorButton.BackgroundColor;
    par.LineWidth = WidthEditField.Value;
    delete(app.GBFig)
    node = app.Tree.SelectedNodes;
    ind = node.NodeData;
    n = arrayfun(@(b)(b.No),app.test) == ind;
    if ~app.test(n).GrainBoundaryCalculateFlag
        uiprogressdlg(app.SchmidtfactorcalculatorUIFigure, ...
                    'Message','Generating GB ...', ...
                    'Title','GB', ...
                    'Indeterminate','on');
    end
    app.test(n) = app.test(n).CalculateGrainBoundary(app,par);
    % app.test(n) = app.test(n).PlotGrainBoundary(1,app);
    app.PloNo = find(n);
    app.CatNo = 1; % ?
    app.PloTyp = 4;
    app.Tree.SelectedNodes = app.test(n).GrainBoundaryNode(end);
    TreeActions(app,app.Tree,app);
end

function CancelButtonPushedFcn(~,~)
    delete(app.GBFig)
    return
end
end