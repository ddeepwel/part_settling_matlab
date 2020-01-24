function [] = plot_particle_drift(p1, p2, save_plot, multi_plot)
% plot the drift of the particle pair

if nargin == 0
    p1 = 0;
    p2 = 1;
    make_plot = true;
    save_plot = true;
    multi_plot = false;
elseif nargin == 2
    make_plot = true;
    save_plot = true;
    multi_plot = false;
end

[time, drift, drift_vel] = particle_drift(p1, p2);

figure(70)
if ~multi_plot
    clf
end

subplot(2,1,1)
if multi_plot
    hold on
end
plot(time, drift - drift(1)) % assuming D_p = 1

%xlabel('$t$')
ylabel('$(l-l_0)/D_p$')
title('particle drift')
grid on

subplot(2,1,2)
if multi_plot
    hold on
end
plot(time,drift_vel)

xlabel('$t$')
ylabel('$u_\textrm{drift}/w_s$','Interpreter','Latex')
title('drift velocity')
grid on

figure_defaults()

if save_plot
    check_make_dir('figures')
    cd('figures')
    print_figure('particle_drift','format','pdf','size',[6 4])
    cd('..')
end
