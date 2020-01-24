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

% check if reached bottom and don't plot after this
hit_bottom = reached_bottom();
if hit_bottom
    [tb, ti] = reach_bottom_time;
    inds = 1:ti;
else
    inds = 1:length(time);
end

figure(70)
if ~multi_plot
    clf
end

subplot(2,1,1)
hold on
plot(time(inds), drift(inds) - drift(1)) % assuming D_p = 1
if hit_bottom
    plot(time(ti),drift(ti)-drift(1),'kx')
end

%xlabel('$t$')
ylabel('$(l-l_0)/D_p$')
title('particle drift')
grid on

subplot(2,1,2)
hold on
plot(time(inds),drift_vel(inds))
if hit_bottom
    plot(time(ti),drift_vel(ti),'kx')
end

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
