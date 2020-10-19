function [max_xind, max_yind, max_zind, min_xind, min_yind, min_zind] =  find_grid_point(ii)
% find the grid location where the density is a maximum

params = read_params();
Nx = params.NXM+1;
Ny = params.NYM+1;
Nz = params.NZM+1;

filename = sprintf('Data_%d.h5',ii);
rho = h5read(filename, '/Conc/0');
vf  = h5read(filename, '/vfc');
time= h5read(filename, '/time');

[max_val,max_ind] = max(rho(:) .* (1-vf(:)) );
[min_val,min_ind] = min(rho(:) .* (1-vf(:)) );

[max_xind, max_yind, max_zind] = ind2sub([Nx Ny Nz], max_ind);
[min_xind, min_yind, min_zind] = ind2sub([Nx Ny Nz], min_ind);

fprintf('t = %.3g\n', time)
fprintf('max:  %.5g\n',max_val)
fprintf('grid: %.5g\n',rho(max_xind,max_yind,max_zind) .* (1-vf(max_xind,max_yind,max_zind)) )
fprintf('min:  %.5g\n',min_val)
fprintf('grid: %.5g\n',rho(min_xind,min_yind,min_zind) .* (1-vf(min_xind,min_yind,min_zind)) )
