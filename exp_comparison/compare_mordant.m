% compare the settling from Parties and Camassa 2010


base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/mordant/';

sim_cases = {'lowres', 'midres', 'hires'};

% non-dimensionalizations for the experiment
exp_file = 'fig7_vel.csv';

ws = 0.0741;
Dp = 0.5e-3;
tstar = Dp / ws;

figure(97)
clf
hold on

for mm = 1:length(sim_cases)
    cd([base,sim_cases{mm}])
    [t,y,v] = settling;
    plot(t,v)
end

dat = readtable([base,'/mordant/',exp_file]);
exp_time = dat.Var1;
exp_vel  = dat.Var2;

plot(exp_time / tstar/1000, -exp_vel / ws,'k')

grid on
xlabel('$t / \tau$')
ylabel('$w_p / w_s$')
legend(strrep(sim_cases,'_',' '))

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
print_figure('mordant_comparison','format','pdf','size',[6 4])
cd(orig_dir)
