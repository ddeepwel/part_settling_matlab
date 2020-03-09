function [] = plot_particle_positions()
% plot particle positions and colour by time

% search for particle files
particle_files = dir('mobile_*.dat');
N_files = length(particle_files);

% read particle files
p = cell(1, N_files);
for mm = 1:N_files
    fname = sprintf('mobile_%d', mm-1);
    p{mm} = check_read_dat(fname);
end

% make plot
figure(66)
clf
hold on

time = p{1}.time;
Nt = length(time);
colormap(parula(Nt))
cmap = colormap(parula(Nt));
for mm = 1:N_files
    x = p{mm}.x;
    y = p{mm}.y;
    col = p{mm}.time;
    scatter(x,y,[],col,'fill','SizeData',8)
end

% add horizontal bands at intervals of 5 time units
for ts = 0:5:time(end)
    ind = nearest_index(time, ts);
    cmap_ind = round(ts/time(end) * (Nt-1) + 1);
    plot([p{1}.x(ind) p{2}.x(ind)],[p{1}.y(ind) p{2}.y(ind)], 'Color', cmap(cmap_ind,:))
end

cbar = colorbar;
cbar.Label.String = '$t$';
xlabel('$x/D_p$')
ylabel('$y/D_p$')
title('particle position')
figure_defaults()

% save figure
check_make_dir('figures')
cd('figures')
print_figure('particle_positions','format','pdf','size',[6 4])
cd('..')
