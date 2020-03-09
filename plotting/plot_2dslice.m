% Plot a 2D cross-section of 3D field

field = 'v';
plane = 'z';
val = -0.05;
%ii = 0;

fieldname = ['/',field];
last_out = last_output('Data');

filename = sprintf('Data_%d.h5',0);
data0 = h5read(filename, fieldname);
gd = read_grid(filename);
ind = nearest_index(gd.zc,0);
data2d0 = squeeze(data0(:,:,ind));

for ii = 10%:last_out
    % load data
    filename = sprintf('Data_%d.h5',ii);
    data = h5read(filename, fieldname);
    vf = h5read(filename, '/vfc');
    time = h5read(filename, '/time');

    % load grid
    gd = read_grid(filename);

    ind = nearest_index(gd.zc, val);
    data2d = squeeze(data(:,:,ind));

    figure(83)
    clf
    pcolor(gd.xc, gd.yc, data2d');%.*(1-vf'))
    %pcolor(gd.xc, gd.yc, data2d');%.*(1-vf'))
    shading flat
    colorbar
    caxis([-1 1]*max(abs(data2d(:))));
    colormap(cmocean('balance'))

    title(sprintf('$t_i$ = %d, $t$ = %g',ii,time))
    figure_defaults()
end
