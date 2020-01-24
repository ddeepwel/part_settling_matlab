function [] = plot_particle_separation(p1, p2, save_plot, multi_plot)
% plot separation between two particles

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

[time, sep, sep_vel] = particle_separation(p1, p2);

figure(67)
if ~multi_plot
    clf
end

subplot(2,1,1)
if multi_plot
    hold on
end
plot(time, sep-1) % assuming D_p = 1

%xlabel('$t$')
ylabel('$(s-D_p)/D_p$')
title('particle separation')
grid on

subplot(2,1,2)
if multi_plot
    hold on
end
plot(time,sep_vel)

xlabel('$t$')
ylabel('$u_{sep}/w_s$')
title('separation velocity')
grid on

figure_defaults()

if save_plot
    check_make_dir('figures')
    cd('figures')
    print_figure('particle_separation','format','pdf','size',[6 4])
    cd('..')
end
