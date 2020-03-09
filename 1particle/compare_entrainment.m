% compare volume entrainment for multiple cases


base = '/project/6001470/ddeepwel/part_settling/1particle/thick_strat/';
cases = {...%'sigma10/try1',...
         'test_entrain_Re10',...
         'test_entrain_Re5',...
         'test_entrain_Re2.5',...
         'test_entrain_Re1',...
         'test_entrain_Re0.5',...
         'test_entrain_Re0.25'};

Ncases = length(cases);


figure(42)
clf
hold on

for nn = 1:Ncases
    cd([base,cases{nn}])
    load('entrained_fluid')

    plot(time, volume * 6/pi)
end


xlim([0 60])
ylabel('$V_\textrm{entrain} / V_p$','Interpreter','latex')
xlabel('$t$')
%legend({'$Re=20$','$Re=10$','$Re=5$','$Re=2.5$','$Re=1$'})
legend({'$Re=10$','$Re=5$','$Re=2.5$','$Re=1$','$Re=0.5$','$Re=0.25$'})

figure_defaults();
cd('../figures')
print_figure('entrained','format','pdf','size',[6 4])
cd('..')
