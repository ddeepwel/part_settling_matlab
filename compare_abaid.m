% compare the settling from Parties and Abaid 2004


base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/abaid/';

%sim_case = 'fig9_1.045';
sim_case = 'fig9_1.045_hires';
%sim_case = 'fig9_1.045_halfRi_tall_hires';
%sim_case = 'fig10_1.055';


% non-dimensionalizations for the experiment
inch2cm = 2.54;
if strncmp(sim_case,'fig9_1.045',10)
    exp_file = 'fig9_vel_1.045.csv';

    rho_p = 1.045;
    Mp = 0.0705;
    ws = 2.75 * inch2cm;
    %d0 = 84;
    %d0 = 80;
    d0 = 100;
elseif strcmp(sim_case, 'fig10_1.055')
    exp_file = 'fig10_vel_1.055.csv';

    rho_p = 1.055;
    Mp = 0.0579;
    ws = 3.1 * inch2cm;
    d0 = 96;
end
Dp = (Mp / rho_p * 3/4 / pi)^(1/3) * 2;


cd([base,sim_case])
[t,y,v] = settling;

figure(97)
clf
hold on
plot(-v,y)

dat = readtable([base,'abaid/',exp_file]);
exp_depth = dat.Var1;
exp_vel  = dat.Var2;

plot(exp_vel * inch2cm / ws, d0 - exp_depth * inch2cm / Dp,'.')

grid on
xlabel('$w / w_1$')
ylabel('$h / D_p$')
title(strrep(sim_case,'_',' '))

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
fname = sprintf('Abaid_%s.pdf',sim_case);
print_figure(fname,'format','pdf','size',[6 4])
cd(orig_dir)
