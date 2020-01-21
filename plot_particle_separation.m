function [time,sep, sep_vel] = plot_particle_separation(p1, p2, make_plot)
% plot separation between two particles

if nargin == 0
    p1 = 0;
    p2 = 1;
    make_plot = true;
elseif nargin == 2
    make_plot = true;
end

p1_file = sprintf('mobile_%d.dat', p1);
p2_file = sprintf('mobile_%d.dat', p2);
p1_data = readtable(p1_file);
p2_data = readtable(p2_file);

time = p1_data.time;

sep = sqrt( (p1_data.x - p2_data.x).^2 ...
           +(p1_data.y - p2_data.y).^2 ...
           +(p1_data.z - p2_data.z).^2 );

Dmat = FiniteDiff(time,1,2);
sep_vel = Dmat * sep;

if make_plot
    figure(67)
    clf
    %hold on

    subplot(2,1,1)
    plot(time, sep-1) % assuming D_p = 1

    %xlabel('$t$')
    ylabel('$(s-D_p)/D_p$')
    title('particle separation')

    subplot(2,1,2)
    plot(time,sep_vel)

    xlabel('$t$')
    ylabel('$u_{sep}/w_s$')
    title('separation velocity')

    figure_defaults()

    check_make_dir('figures')
    cd('figures')
    print_figure('particle_separation','format','pdf','size',[6 4])
    cd('..')
end
