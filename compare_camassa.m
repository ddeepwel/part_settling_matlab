% compare the settling from Parties and Camassa 2010


base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/camassa/';

sim_case = 'strat';
    t0 = -5;
%sim_case = 'fig3';
%    t0 = -1.5;

exp_file = 'fig3_vel.csv';
ws = 0.388;
Dp = 2 * 0.635;
tstar = Dp / ws;


cd([base,sim_case])
[t,y,v] = settling;

figure(97)
clf
hold on
plot(t,v)

dat = readtable([base,'camassa/',exp_file]);
exp_time = dat.Var1;
exp_vel  = dat.Var2;

plot(t0 + exp_time / tstar, -exp_vel / ws)

grid on
xlabel('$t / \tau$')
ylabel('$w_p / w_s$')
title(strrep(sim_case,'_',' '))

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
print_figure('Camassa2010','format','pdf','size',[6 4])
cd(orig_dir)
