% Plot a 2D cross-section of 3D field

% options
%field = 'Conc/0';
field = 'Conc/1';
plane = 'z';
val = -0;
outputs = 0:6;

% setup
fieldname = ['/',field];
last_out = last_output('Data');

%filename = sprintf('Data_%d.h5',0);
%data0 = h5read(filename, fieldname);
%gd = read_grid(filename);
%ind = nearest_index(gd.zc,0);
%data2d0 = squeeze(data0(:,:,ind));

for ii = outputs
    % load data
    filename = sprintf('Data_%d.h5',ii);
    data = h5read(filename, fieldname);
    vf = h5read(filename, '/vfc');
    time = h5read(filename, '/time');
    if strcmp(field, 'Conc/1')
        data = 1-data;
    end

    % load grid
    gd = read_grid(filename);

    ind = nearest_index(gd.zc, val);
    data2d = squeeze(data(:,:,ind));
    vf2d   = squeeze(  vf(:,:,ind));

    figure(85)
    clf
    hold on
    pcolor(gd.xc, gd.yc, data2d'.*(1-vf2d'))
    %contour(gd.xc, gd.yc, data2d'.*(1-vf2d'), 30)
    %pcolor(gd.xc, gd.yc, data2d');%.*(1-vf'))
    shading flat
    colorbar
    caxis([-1 1]*max(abs(data2d(:))));
    colormap(cmocean('balance'))

    warning('off','MATLAB:contour:ConstantData')
    contour(gd.xc, gd.yc, (1-vf2d'), [1 1])
    warning('on','MATLAB:contour:ConstantData')

    title(sprintf('%s, $z$ = %5.3g, $t_i$ = %d, $t$ = %5.3g',field,gd.zc(ind),ii,time))
    figure_defaults()
end
