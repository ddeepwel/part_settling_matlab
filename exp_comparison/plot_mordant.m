% compare the settling from Parties and Camassa 2010

base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/mordant/';

sim_cases = {'midres'};

% non-dimensionalizations for the experiment
%exp_file = 'fig7_vel.csv';
exp_file = 'fig7_vel_new.csv';

ws = 0.0741;
Dp = 0.5e-3;
tstar = Dp / ws;

cols = default_line_colours();

figure(97)
clf
hold on

dat = readtable([base,'/mordant/',exp_file]);
exp_time = dat.Var1;
exp_vel  = dat.Var2;

plot([0 50],[1 1]*-1,'Color',[1 1 1]*0.5);

cd([base,sim_cases{mm}])
[t,y,v] = settling;
p1 = plot(t,v, 'Color', cols(mm,:));

p2 = plot(exp_time / tstar/1000, -exp_vel / ws, 'k--');

%grid on
xlabel('$t / \tau$')
ylabel('$w_p / w_\mathrm{max}$','Interpreter','latex')
legend([p1 p2],'Present study','Mordant \& Pinton (2000)')
legend('boxoff')
xlim([0 25])

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
print_figure('mordant2000','format','pdf','size',[6 4])
cd(orig_dir)
