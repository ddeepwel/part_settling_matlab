function [] = plot_entrain_dye(save_plot, multi_plot)
% plot the mass entrainment
% the integral of (rho_background - rho)
% where this comes from the statistics from parties
% rather than the full 3D fields

if nargin == 0
    save_plot = true;
    multi_plot = false;
end

load('entrained_tracer')
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

%plot(time, volume * 6/pi * (1-gam) * (1-1/rho_s))
plot(time, volume * 6/pi);

ylabel('$M_\textrm{entrain} / M_p$','Interpreter','latex')
xlabel('$t/\tau$')
%xlim([0 50])

figure_defaults();

if save_plot
    check_make_dir('figures')
    cd('figures')
    print_figure('entrain_dye','format','pdf','size',[6 4])
    cd('..')
end
