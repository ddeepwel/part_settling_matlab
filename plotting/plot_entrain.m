function [] = plot_entrain(save_plot, multi_plot)
% plot the volume entrainment
% the volume rho<rho(z_pyc) that is below the centre of the pycnocline (z_pyc)

if nargin == 0
    save_plot = true;
    multi_plot = false;
end

load('entrained_fluid')
max_entrain = max(volume);

% make figure
figure(63)
if ~multi_plot
    clf
end
hold on

plot(time, volume * 6/pi)

ylabel('$V_\textrm{entrain} / V_p$','Interpreter','latex')
xlabel('$t/\tau$')
xlim([0 50])

figure_defaults();

if save_plot
    check_make_dir('figures')
    cd('figures')
    %print_figure('entrain','format','pdf','size',[6 4])
    cd('..')
end
