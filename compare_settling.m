% compare the settling speeds for multiple cases


base = '/project/6001470/ddeepwel/part_settling/1particle/thick_strat/';
cases = {'sigma10/try1',...
         'test_entrain_Re10',...
         'test_entrain_Re5',...
         'test_entrain_Re2.5',...
         'test_entrain_Re1',...
         'test_entrain_Re0.5',...
         'test_entrain_Re0.25'}
         %'test_entrain_Re0.1'};

% Re = 0.1 is too noisy. Ignore it
% It's a limitation of the particle resolving code (cannot do small Re)
% Maybe a higher resolution run will do better since the velocity is
% CLOSE to what it should be

Ncases = length(cases);


figure(41)
clf
subplot(2,1,1)
hold on
subplot(2,1,2)
hold on


for nn = 1:Ncases
    cd([base,cases{nn}])
    [time, y_p, vel] = plot_settling();

    figure(41)
    subplot(2,1,1)
    plot(time, y_p)
    subplot(2,1,2)
    plot(time, vel)
end

subplot(2,1,1)
xlim([0 80])
ylabel('$h_p/D_p$')
legend({'$Re=20$','$Re=10$','$Re=5$','$Re=2.5$','$Re=1$','$Re=0.5$','$Re=0.25$'})

subplot(2,1,2)
xlim([0 80])
ylabel('$w_p/w_s$')
xlabel('$t$')

figure_defaults();
cd('../figures')
print_figure('settling','format','pdf','size',[6 4])
cd('..')
