function StartUpCheck(app)
ind = zeros(1,9);
ind(app.CalLis) = 1;
ind = arrayfun(@fun,ind,'UniformOutput',false);
ind = flip(ind);
[app.DeformationsystemsselectionMenu.Children.Checked] = ...
    ind{:};
fun2(app.ComputingmethodMenu,app.CalMet);
fun2(app.ConvertmethodMenu,app.ConMet);
fun2(app.MaterialMenu,app.AxiRatNam);
fun2(app.AngleunitMenu,app.AngUni);
fun2(app.StressMenu,app.StrStaNam);
fun2(app.WindowsizeMenu,app.WinSiz);
end
function val = fun(i)
if i; val ='on'; else; val = 'off'; end
end
function fun2(obj,prop)
name = {obj.Children.Text};
ind = strcmp(prop,name);
ind = arrayfun(@fun,ind,'UniformOutput',false);
[obj.Children.Checked] = ...
    ind{:};
end