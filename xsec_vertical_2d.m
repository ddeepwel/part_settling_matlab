function [y, xsec, vfsec] = xsec_vertical_2d(field, ii, position);
% make a vertical cross-section

group = 'xy';

% load grid
filename_2d = sprintf('Data2d_%d.h5',ii);
gd = read_grid(filename_2d);

y = gd.y;

fieldname = ['/',group,'/',field];
filename_2d = sprintf('Data2d_%d.h5',ii);


data1 = h5read(filename_2d, ['/xy1/',field]);
data2 = h5read(filename_2d, ['/xy2/',field]);
data = (data1 + data2)/2;

vf1 = h5read(filename_2d, ['/xy1/vf']);
vf2 = h5read(filename_2d, ['/xy2/vf']);
vf = (vf1 + vf2)/2;

xind1 = nearest_index(gd.x, position);
if position == 0
    if gd.x(xind1) < position
        xind2 = xind1 + 1;
    else
        xind2 = xind1 - 1;
    end

    xsec  = ( data(xind1,:) + data(xind2,:) ) / 2;
    vfsec = (   vf(xind1,:) +   vf(xind2,:) ) / 2;
else
    xsec = data(xind1,:);
    vfsec =  vf(xind1,:);
end

