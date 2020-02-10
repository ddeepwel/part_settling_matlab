function [] = plot_particle_relpath()
% plot relative particle path of particle 0
% with respect to particle 1


particle_files = dir('mobile_*.dat');
N_files = length(particle_files);

p = cell(1, N_files);
for mm = 1:N_files
    fname = sprintf('mobile_%d', mm-1);
    p{mm} = check_read_dat(fname);
end

% check if reached bottom and don't plot after this
hit_bottom = reached_bottom();
if hit_bottom
    [tb, ti] = reach_bottom_time;
    inds = 1:ti;
else
    inds = 1:length(p{1}.time);
end

figure(71)
clf
hold on

time = p{1}.time(inds);
Nt = length(time);
colormap(parula(Nt))
cmap = colormap(parula(Nt));
x = p{1}.x(inds) - p{2}.x(inds);
y = p{1}.y(inds) - p{2}.y(inds);
col = p{mm}.time(inds);
scatter(x,y,[],col,'fill','SizeData',8)
%plot(x,y,'k')
plot(0, 0, 'ko')

cbar = colorbar;
cbar.Label.String = '$t$';

xlabel('$x/D_p$')
ylabel('$y/D_p$')
title('particle 2 path relative to particle 1')
figure_defaults()

check_make_dir('figures')
cd('figures')
print_figure('particle_relpath','format','pdf','size',[6 4])
cd('..')
