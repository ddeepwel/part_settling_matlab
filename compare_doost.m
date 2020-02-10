% compare the settling speeds of a linear stratification
% from figure 3 in Doostmohammadi 2014


base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/Doost2014/';
cases = {'Frinf_reshi',...
    'Fr16.2',...
    'Fr6.49',...
    'Fr3.25',...
    ...%'Fr3.25_reshi',...
    ...%'Fr3.25_halfRi',...
    'Fr1.62',...
    'Fr1.15',...
    'Fr0.829'};
    %'Fr0.829_halfRi'};
lab = {'$Fr=\infty$',...
    '$Fr = 16.2$',...
    '$Fr = 6.49$',...
    '$Fr = 3.25$',...
    '$Fr = 1.62$',...
    '$Fr = 1.15$',...
    '$Fr = 0.829$'};

Ncases = length(cases);

figure(88)
clf
hold on

% plot Parties results
for mm = 1:Ncases
    cd([base,cases{mm}])
    [t, y, v] = settling();
    plot(t,v,'-')
end

% conversion between parties and Doost. temporal scaling
Re = 14.1;
rho_s = 1.14;
nu = 1e-6;
g = 9.81;
dp3 = 18 * Re / (rho_s-1) * nu^2 / g;
dp = dp3^(1/3);
tt = 18 / (rho_s-1) * nu / sqrt(dp^3 * g);

% plot Doostmohammadi's results
cd('../Doost2014')

files = {'Doost_Frinf.csv',...
    'Doost_Fr16.2.csv',...
    'Doost_Fr6.49.csv',...
    'Doost_Fr3.25.csv',...
    'Doost_Fr1.62.csv',...
    'Doost_Fr1.15.csv',...
    'Doost_Fr0.829.csv'};

for mm = 1:length(files)
    dat = readtable(files{mm});
    plot(dat.Var1/tt, dat.Var2,'--')
end

ylabel('$w_p/w_s$')
xlabel('$t$')
grid on
xlim([0 20])
leg = legend(lab);
leg.Location = 'EastOutside';


figure_defaults()
check_make_dir('../figures');
cd('../figures')
print_figure('Doost2014','format','pdf','size',[8 4])

