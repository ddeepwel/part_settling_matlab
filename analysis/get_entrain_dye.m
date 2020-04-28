% compute the entrained mass for a simulation
% using the full 3D fields


gd = read_grid();
par = read_params();

Nx = length(gd.xc);
Ny = length(gd.yc);
Nz = length(gd.zc);
dt = par.output_time_interval;
dx = gd.yc(2) - gd.yc(1);

first_out = 0;
last_out = last_output('Data');

M_entrain = zeros(1,last_out+1);

for ii = first_out:last_out
    fname = sprintf('Data_%d.h5',ii);
    dye = h5read(fname,'/Conc/1');
    vf  = h5read(fname,'/vfc');

    % background stratification
    dye_bg = dye(1,:,1); 
    dye_bg_full = repmat(dye_bg, [Nx, 1, Nz]);
    % perturbation density (dye')
    dye_prime = (dye_bg_full - dye) .* (1-vf);

    % volume integral of dye'
    M_entrain(ii+1) = sum(dye_prime(:)) * dx^3;

    %pcolor(gd.xc,gd.yc,squeeze(dye_prime(:,:,90))');
    %shading flat
    %colormap(cmocean('balance'))
    %caxis([-1 1]*0.6)
    %colorbar
    %drawnow

    completion(ii+1, last_out+1)
end

time = (0:last_out) * dt;

save('entrained_dye','time','M_entrain')
