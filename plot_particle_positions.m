function [] = plot_particle_positions()
% plot particle positions


particle_files = dir('mobile_*.dat');
N_files = length(particle_files);

p = cell(1, N_files);
for mm = 1:N_files
    fname = sprintf('mobile_%d.dat', mm-1);
    p{mm} = readtable(fname);
end

figure(66)
clf
hold on

time = p{1}.time;
colormap(parula(length(time)))
cmap = colormap(parula(length(time)));
for mm = 1:N_files
    %plot(p{mm}.x, particles{mm}.y, 'k')
    %legend_label{mm} = sprintf('Particle %d',mm);
    x = p{mm}.x;
    y = p{mm}.y;
    col = p{mm}.time;
    surface([x,x], [y,y], [col,col],...
        'facecol','no','edgecol','interp','linew',2);
end

%for ts = linspace(0,time(end), 10)
for ts = 0:5:time(end)
    ind = nearest_index(p{1}.time, ts);
    plot([p{1}.x(ind) p{2}.x(ind)],[p{1}.y(ind) p{2}.y(ind)], 'Color', cmap(ind,:))
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
