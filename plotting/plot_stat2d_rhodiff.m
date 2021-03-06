function [data, vf, xvar, yvar] = plot_stat2d(t_index, varargin);
% Plot the difference of the density field from the background
% (taken to be the far field profile)

group = 'xy';
field = 'c0';

if nargin == 5
    fnum = varargin{1};
    clim = varargin{2};
else
    if nargin == 4
        fnum = varargin{1};
    else
        fnum = 95;
    end
    %if strcmp(field, 'c0')
    %    clim = [0 1];
    %elseif strcmp(field, 'KE_h')
    %    clim = 'auto';
    %else
    %    clim = 'auto';
    %end
    clim = 'auto';
end

% load grid
filename_2d = sprintf('Data2d_%d.h5',t_index(1));
gd = read_grid(filename_2d);

% select grid variables and labels
% shift grid so that ticks show up nicely
dx = gd.x(2) - gd.x(1);
dy = gd.y(2) - gd.y(1);
dz = gd.z(2) - gd.z(1);
if strcmp(group(1:2), 'xy')
    xvar = gd.x - dx/2;
    yvar = gd.y - dy/2;
    xlab = '$x/D_p$';
    ylab = '$y/D_p$';
elseif strcmp(group(1:2), 'xz') || strcmp(group, 'integral_y')
    xvar = gd.x - dx/2;
    yvar = gd.z - dz/2;
    xlab = '$x/D_p$';
    ylab = '$z/D_p$';
end
%if strcmp(field, 'c0')
%    cmap = cmocean('tempo');
%elseif strcmp(field, 'KE_h')
%    cmap = cmocean('-ice');
%else
%    cmap = cmocean('balance');
%end
cmap = cmocean('balance');

fieldname = ['/',group,'/',field];

% loop over output indices
for ii = t_index
    % load data
    filename_2d = sprintf('Data2d_%d.h5',ii);
    if strcmp(group(1:2), 'xy')
        % get data at z=0 as avg of data a half grid cell off on either side
        data1 = h5read(filename_2d, ['/xy1/',field]);
        data2 = h5read(filename_2d, ['/xy2/',field]);
        data = (data1 + data2)/2;

        vf1 = h5read(filename_2d, ['/xy1/vf']);
        vf2 = h5read(filename_2d, ['/xy2/vf']);
        vf = (vf1 + vf2)/2;

        xsec1 = h5read(filename_2d, '/xy1/z');
        xsec2 = h5read(filename_2d, '/xy2/z');
        xsec = (xsec1 + xsec2)/2;
        seclab = sprintf('$z/D_p=%2.0f$', xsec);
    elseif strcmp(field, 'KE_h')
        u = h5read(filename_2d, ['/',group,'/u']);
        w = h5read(filename_2d, ['/',group,'/w']);
        data = 0.5 * (u.^2 + w.^2);

        % volume fraction
        vf = h5read(filename_2d, ['/',group,'/vf']);

        xsec = h5read(filename_2d, ['/',group,'/y']);
        seclab = sprintf('$y/D_p=%2.0f$', xsec);
    else
        data = h5read(filename_2d, fieldname);
        if strcmp(group, 'integral_y')
            vf = 0;
            seclab = '$\int dy$';
        else
            xsec = h5read(filename_2d, ['/',group,'/y']);
            seclab = sprintf('$y/D_p=%2.0f$', xsec);
            % volume fraction
            vf = h5read(filename_2d, ['/',group,'/vf']);
        end
    end
    strat = get_background_strat_full(ii);
    time = h5read(filename_2d, '/time');

    % make figure
    figure(fnum)
    clf
    hold on
    pcolor(xvar, yvar, (data' - strat').*(1-vf'))
    shading flat
    %contour(xvar, yvar, data'.*(1-vf'), [1 1]*0.5)
    %contour(xvar, yvar, data'.*(1-vf'), 20)
    if ~strcmp(group, 'integral_y')
        warning('off','MATLAB:contour:ConstantData')
        contour(xvar, yvar, (1-vf'),[1 1])
        warning('on','MATLAB:contour:ConstantData')
    end

    colorbar
    xlabel(xlab)
    ylabel(ylab)
    if ischar(clim)
        caxis([-1 1]*max(abs(data(:))));
    else
        caxis(clim)
    end
    colormap(cmap)

    %title(sprintf('$%s$, $t_n$ = %d, $t$ = %2.2g',strrep(field, '_', ' '), ii,time))
    if strcmp(field, 'c_curve_diag')
        field = '\textrm{c curvature}';
    end
    ttl = sprintf('$%s$, $t/\\tau$ = %2.2g, %s',field, time, seclab);
    title(ttl, 'Interpreter','Latex');
    figure_defaults()
end
