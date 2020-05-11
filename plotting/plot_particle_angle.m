function p_h = plot_particle_angle(p1, p2, save_plot, multi_plot)
% plot angle between two particles relative to the vertical

if nargin == 0
    p1 = 0;
    p2 = 1;
    save_plot = true;
    multi_plot = false;
elseif nargin == 2
    save_plot = true;
    multi_plot = false;
end

[time, ang] = particle_angle(p1, p2);

% check if reached bottom and don't plot after this
hit_bottom = reached_bottom();
if hit_bottom
    [tb, ti] = reach_bottom_time;
    inds = 1:ti;
else
    inds = 1:length(time);
end

figure(68)
if ~multi_plot
    clf
end

%subplot(2,1,1)
hold on
plot(time(inds), ang(inds)-1) % assuming D_p = 1
if hit_bottom
    plot(time(ti),ang(ti)-1,'kx')
end

xlabel('$t/\tau$')
ylabel('$\theta$ ($^\circ$)')
title('particle orientation angle')
%yl = ylim();
%ylim([0 yl(2)])
grid on

%subplot(2,1,2)
%hold on
%p_h = plot(time(inds),sep_vel(inds));
%if hit_bottom
%    plot(time(ti),sep_vel(ti),'kx')
%end

%xlabel('$t/\tau$')
%ylabel('$u_{sep}/w_s$')
%title('separation velocity')
%grid on

figure_defaults()

if save_plot
    check_make_dir('figures')
    cd('figures')
    print_figure('particle_angle','format','pdf','size',[6 4])
    cd('..')
end
