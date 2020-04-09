% compare the settling from Parties and Camassa 2010


%base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/mordant/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/comparisons_and_checks/tencate/';

sim_cases = {'try1'};

% non-dimensionalizations for the experiment
exp_file = 'fig5b_Re1_5.csv';

ws = 0.038;
Dp = 0.015;
tstar = Dp / ws;

figure(97)
clf
hold on

for mm = 1:length(sim_cases)
    cd([base,sim_cases{mm}])
    [t,y,v] = settling;
    plot(t,v)
end

dat = readtable([base,'/tencate/',exp_file]);
exp_time = dat.Var1;
exp_vel  = dat.Var2;

plot(exp_time / tstar, exp_vel / ws,'k.')

grid on
xlabel('$t / \tau$')
ylabel('$w_p / w_s$')
legend(strrep(sim_cases,'_',' '))

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
print_figure('tencate_comparison','format','pdf','size',[6 4])
cd(orig_dir)
