% make the article key image for the journal website

add_parties
add_subdirs('part_settling')

cd('/Volumes/2part_settling/2particles/sigma1/Re1_4/gamm0.5/s2_th45_dx25/')

time_2d = get_output_times('Data2d');
tind = nearest_index(time_2d, 40);
[data, vf, xvar, yvar, xy_p] = plot_stat2d('xy', 'c0', tind,95,[0 1],'contourf');

axis image
axis([-6 6 13 25])
xticks([])
yticks([])
xlabel('')
ylabel('')
title('')
colorbar off

cd('../../figures')
print_figure('keyfigure','format','jpeg','res',600,'size',[4 3])
