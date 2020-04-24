% compare the settling speeds of a linear stratification
% from figure 3 in Doostmohammadi 2014


%base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/Doost2013-2parts/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/comparisons_and_checks/Doost2013-2parts/';
cases = {
    'Frinf_tall',...
    'Fr20',...
    ...%'Fr20_dx50',...
    };
lab = {
    '$Fr = \infty$',...
    '$Fr = 20$',...
    ...%'$Fr = 20$, dx=50',...
    };
% comparison files
files = {...
    'Doost2013_fig1_Frinf.csv',...
    'Doost2013_fig1_Fr20.csv',...
    };

Ncases = length(cases);

figure(81)
clf
hold on

% plot Parties results
for mm = 1:Ncases
    cd([base,'fig1/',cases{mm}])
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

cols = default_line_colours();

for mm = 1:length(files)
    dat = readtable(files{mm});
    plot(dat.Var1/tt, dat.Var2,'--','Color',cols(mm,:))
end

%plot([0 25],[1 1]*0,'Color',[1 1 1]*0.5)

ylabel('$(s-D_p)/D_p$')
xlabel('$t/\tau$')
%grid on
xlim([0 150])
leg = legend(lab);
leg.Box = 'off';
%leg.Location = 'EastOutside';
%leg.String = leg.String{1:end-1};



figure_defaults()
check_make_dir('../figures');
cd('../figures')
print_figure('Doost2013_fig1','format','pdf','size',[6 4])

