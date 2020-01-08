function [x,u_mid] = plot_radial_convergence(plane_index, ii, field)
% plot the horizontal velocity at a particular plane

if nargin == 2
    field = 'u';
end

if strcmp(field,'u')
    title_field = 'u_r';
else
    title_field = field;
end

params = read_params();
Nz = params.NZM;

% load grid
filename_2d = sprintf('Data2d_%d.h5', ii);
gd = read_grid(filename_2d);
dx = gd.x(2) - gd.x(1);
x = gd.x - dx/2;

group = sprintf('xz%d',plane_index);
field_name = sprintf('/%s/%s',group, field);
u = h5read(filename_2d, field_name);
u_mid = u(:,round(Nz/2));

figure(59)
clf
plot(x, u_mid)
xlim([0 max(x(:))])
grid on
xlabel('$r/D_p$')
ylab = sprintf('$%s / w_s$', title_field);
ylabel(ylab)
ylim([-0.25 0.05])

xsec = h5read(filename_2d, ['/',group,'/y']);
time = h5read(filename_2d, '/time');
ttl = sprintf('$t=%2.2g$, $y = %2.0f$', time, xsec);
title(ttl)

figure_defaults();
check_make_dir('figures')
cd('figures')
filename = sprintf('velocity_%s',title_field);
print_figure(filename,'format','pdf','size',[6 4])
cd('..')
