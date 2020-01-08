% compare volume entrainment for multiple cases


base = '/project/6001470/ddeepwel/part_settling/1particle/thick_strat/';
cases = {...%'sigma10/try1',...
         'test_entrain_Re10',...
         'test_entrain_Re5',...
         'test_entrain_Re2.5',...
         'test_entrain_Re1',...
         'test_entrain_Re0.5',...
         'test_entrain_Re0.25'};

Re = [10 5 2.5 1 0.5 0.25];

Ncases = length(cases);
max_entrain = zeros(Ncases,1);

for nn = 1:Ncases
    cd([base,cases{nn}])
    load('entrained_fluid')
    max_entrain(nn) = max(volume);
end

figure(43)
clf
plot(Re, max_entrain,'ok')

ylabel('max $V_\textrm{entrain} / V_p$','Interpreter','latex')
xlabel('$Re$')

figure_defaults();
cd('../figures')
print_figure('max_entrain_vs_Re','format','pdf','size',[6 4])
cd('..')
