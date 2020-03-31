function [] = plot_particle_separation(p1, p2, save_plot, multi_plot)
% plot separation between two particles

if nargin == 0
    p1 = 0;
    p2 = 1;
    save_plot = true;
    multi_plot = false;
elseif nargin == 2
    save_plot = true;
    multi_plot = false;
end

% read data
[time, sep_x, vel_x, sep_y, vel_y, sep_z, vel_z] = particle_separation_component(p1,p2);

figure(69)
if ~multi_plot
    clf
end

%% x-component
subplot(2,3,1)
if multi_plot
    hold on
end
plot(time, sep_x-1) % assuming D_p = 1

%xlabel('$t$')
ylabel('$(s_x-D_p)/D_p$')
title('particle x-separation')

subplot(2,3,4)
if multi_plot
    hold on
end
plot(time,vel_x)

xlabel('$t$')
ylabel('$u_{x_sep}/w_s$')
title('separation x-velocity')


%% y-component
subplot(2,3,2)
if multi_plot
    hold on
end
plot(time, sep_y-1) % assuming D_p = 1

%xlabel('$t$')
ylabel('$(s_y-D_p)/D_p$')
title('particle y-separation')

subplot(2,3,5)
if multi_plot
    hold on
end
plot(time,vel_y)

xlabel('$t$')
ylabel('$u_{y_sep}/w_s$')
title('separation y-velocity')


%% z-component
subplot(2,3,3)
if multi_plot
    hold on
end
plot(time, sep_z-1) % assuming D_p = 1

%xlabel('$t$')
ylabel('$(s_z-D_p)/D_p$')
title('particle z-separation')

subplot(2,3,6)
if multi_plot
    hold on
end
plot(time,vel_z)

xlabel('$t$')
ylabel('$u_{z_sep}/w_s$')
title('separation z-velocity')


figure_defaults()

if save_plot
    check_make_dir('figures')
    cd('figures')
    %print_figure('particle_separation_components','format','pdf','size',[12 4])
    cd('..')
end
