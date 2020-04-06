% compare the settling from Parties and Doostmohommadi 2013 figure 10


base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/Doost2013-2parts';

sim_cases = {
    '/fig10/Re50/',...
    };
lab = {
    '$Re=50$',...
    };

% non-dimensionalizations for the experiment
exp_file = 'Doost2013_fig10_Re50.csv';

%ws = 0.0741;
%Dp = 0.5e-3;
%tstar = Dp / ws;

figure(82)
clf
hold on

for mm = 1:length(sim_cases)
    cd([base,sim_cases{mm}])
    [time, sep, sep_vel] = particle_separation();
    plot(time, (sep-1)/1, '-')
end

% conversion between parties and Doost. temporal scaling
Re = 50;
rho_s = 1.14;
nu = 1e-6;
g = 9.81;
%dp3 = 18 * Re / (rho_s-1) * nu^2 / g;
dp = (Re * nu)^(2/3) / g^(1/3);
ws = 1/18 * (rho_s - 1) * g * dp^2 / nu;

t_doost = sqrt(dp / g);
t_parties = dp/ws;
tt = t_parties / t_doost; %18 / (rho_s-1) * nu / sqrt(dp^3 * g);

% plot Doostmohammadi's results
cd('../../Doost2013')

files = {...
    'Doost_fig10_Re50.csv',...
    };

for mm = 1:length(files)
    dat = readtable(files{mm});
    plot(dat.Var1/tt, dat.Var2, '--')
end

%grid on
xlabel('$t / \tau$')
ylabel('$w_p / w_s$')
leg = legend(lab);
leg.Location = 'Best';

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
%print_figure('Doost2013_comparison','format','pdf','size',[6 4])
cd(orig_dir)
