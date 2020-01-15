function [] = plot_particle_separation(p1, p2)
% plot separation between two particles

if nargin == 0
    p1 = 0;
    p2 = 1;
end

p1_file = sprintf('mobile_%d.dat', p1);
p2_file = sprintf('mobile_%d.dat', p2);
p1_data = readtable(p1_file);
p2_data = readtable(p2_file);


sep = sqrt( (p1_data.x - p2_data.x).^2 ...
           +(p1_data.y - p2_data.y).^2 );

time = p1_data.time;

figure(67)
clf

plot(time, sep-1) % assuming D_p = 1

xlabel('$t$')
ylabel('$(s-D_p)/D_p$')
title('particle separation')
figure_defaults()

check_make_dir('figures')
cd('figures')
print_figure('particle_separation','format','pdf','size',[6 4])
cd('..')
