% compare the settling from Parties and Camassa 2010


base = '/home/ddeepwel/scratch/bsuther/part_settling/comparisons_and_checks/glowinski/';
%base = '/Users/daviddeepwell/ComputeCanada/graham_scratch/bsuther/part_settling/comparisons_and_checks/glowinski/';

sim_cases = {...
    'try1',...
    ...%'try1_boundaries',... % no different than try1
    'try2',...
    'try3'...
    };

% non-dimensionalizations for the experiment
exp_file = {'fig8_20b_p1.csv',...
            'fig8_20b_p2.csv'};

rho_s = 1.14;
Dp = 1/6/100; % m
ws = St_velocity(rho_s,Dp);
tstar = Dp / ws;

figure(98)
clf
hold on

for mm = 1:length(sim_cases)
    cd([base,sim_cases{mm}])
    [t,y,v] = settling(0);
    plot(t,v)
    [t,y,v] = settling(1);
    plot(t,v)
end

cols = default_line_colours();
for mm = 1:length(exp_file)
    dat = readtable([base,'/glowinski/',exp_file{mm}]);
    exp_time = dat.Var1;
    exp_vel  = dat.Var2;

    plot(exp_time / tstar, exp_vel/100 / ws,'--', 'Color',cols(mm,:))
end

grid on
xlabel('$t / \tau$')
ylabel('$w_p / w_s$')
%legend(strrep(sim_cases,'_',' '))

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
%print_figure('glowinski_comparison','format','pdf','size',[6 4])
cd(orig_dir)
