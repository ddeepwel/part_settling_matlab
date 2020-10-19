function [] = plot_entrain_mass(save_plot, multi_plot)
% plot the mass entrainment
% the integral of (rho_background - rho)

if nargin == 0
    save_plot = true;
    multi_plot = false;
end

try
    load('entrained_tracer')
    mass = volume * 6/pi;% * (1-gam) * (1-1/rho_s);
catch
    load('entrained_mass')
    mass = M_entrain * 6/pi;% * (1-gam) * (1-1/rho_s);
end

par = read_params();
Ri = par.richardson;
Re = par.Re;
gam = 1 - Ri(1) * Re / 18;
rho_s = par.rho_s;

% make figure
figure(63)
if ~multi_plot
    clf
end
hold on

%plot(time, M_entrain * 6/pi * (1-gam) * (1-1/rho_s),'x')
plot(time, mass);

ylabel('entrained fluid (unitless)','Interpreter','latex')
xlabel('$t/\tau$')
%xlim([0 50])

figure_defaults();

if save_plot
    check_make_dir('figures')
    cd('figures')
    %print_figure('entrain_mass','format','pdf','size',[6 4])
    cd('..')
end
