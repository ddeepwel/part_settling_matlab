% find the grid location where the density is a maximum

params = read_params();
Nx = params.NXM+1;
Ny = params.NYM+1;
Nz = params.NZM+1;

rho10 = h5read('Data_10.h5','/Conc/0');
vf10  = h5read('Data_10.h5','/vfc');

[mx,ind] = max(rho10(:) .* (1-vf10(:)) );

[xind, yind, zind] = ind2sub([Nx Ny Nz], ind);

fprintf('max:  %.5g\n',mx)
fprintf('grid: %.5g\n',rho10(xind,yind,zind) .* (1-vf10(xind,yind,zind)) )
