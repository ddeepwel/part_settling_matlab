function [] = plot_particle_positions()
% plot particle positions


particle_files = dir('mobile_*.dat');
N_files = length(particle_files);

particles = cell(1, N_files);
for mm = 1:N_files
    fname = sprintf('mobile_%d.dat', mm-1);
    particles{mm} = readtable(fname);
end

figure(66)
clf
hold on

for mm = 1:N_files
    %plot(particles{mm}.x, particles{mm}.y, 'k')
    %legend_label{mm} = sprintf('Particle %d',mm);
    x = particles{mm}.x;
    y = particles{mm}.y;
    col = particles{mm}.time;
    surface([x,x], [y,y], [col,col],...
        'facecol','no','edgecol','interp','linew',2);
end

cbar = colorbar;
cbar.Label.String = '$t$';

xlabel('$x/D_p$')
ylabel('$y/D_p$')
title('particle position')
%legend_handle = legend(legend_label);
%legend_handle.Location = 'Best';
figure_defaults()

check_make_dir('figures')
cd('figures')
print_figure('particle_positions','format','pdf','size',[6 4])
cd('..')
