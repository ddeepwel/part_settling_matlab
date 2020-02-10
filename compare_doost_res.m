% compare the settling speeds of a linear stratification
% from figure 3 in Doostmohammadi 2014


base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/Doost2014/';
cases = {'Frinf_reslo',...
    'Frinf',...
    'Frinf_reshi',...
    'Fr3.25',...
    'Fr3.25_reshi'};
lab = {'$Fr=\infty$, $D_p/\Delta x = 10$',...
    '$Fr=\infty$, $D_p/\Delta x = 20$',...
    '$Fr=\infty$, $D_p/\Delta x = 40$',...
    '$Fr = 3.25$, $D_p/\Delta x = 20$',...
    '$Fr = 3.25$, $D_p/\Delta x = 40$'};

Ncases = length(cases);

figure(88)
clf
hold on

% plot Parties results
for mm = 1:Ncases
    cd([base,cases{mm}])
    [t, y, v] = settling();
    if mm == 1
        plot(t,v,'b:')
    elseif mm == 2
        plot(t,v,'b-')
    elseif mm == 3
        plot(t,v,'b--')
    elseif mm == 4
        plot(t,v,'r-')
    elseif mm == 5
        plot(t,v,'r--')
    end
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
    'Doost_Fr3.25.csv'};

for mm = 1:length(files)
    dat = readtable(files{mm});
    plot(dat.Var1/tt, dat.Var2,'k-')
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
print_figure('Doost2014_res','format','pdf','size',[8 4])

