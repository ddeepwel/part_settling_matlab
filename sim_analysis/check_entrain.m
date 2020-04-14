% recalculate the entrained fluid from full density and volume fraction fields

par = read_params();

time = 24;
rho_c = 0.5;
y_c = (par.ymax + par.ymin)/2;

ii = 24/6;


rho = h5read('Data_4.h5','/Conc/0');
vf = h5read('Data_4.h5','/vfc');
gd = read_grid();

[Nx, Ny, Nz] = size(rho);
yfull = repmat(gd.yc',[Nx, 1, Nz]);
dx = gd.yc(2) - gd.yc(1);

V_ent = (rho < rho_c) .* (yfull < y_c) .* (1-vf);
V_ent = sum(V_ent(:)) * dx^3;

% entrained volume to particle volume ratio
V_Vp = V_ent * 6/pi
