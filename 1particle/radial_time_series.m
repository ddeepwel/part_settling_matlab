function [] = radial_time_series(plane_index, field)
    % make a radial time series at some depth for a field


params = read_params();
Nx = params.NXM + 1;

Noutputs = last_output('Data2d') + 1;
vel_tx = zeros(Noutputs,Nx);


for mm = 1:Noutputs
    ii = mm - 1;

    [x, xsec] = plot_radial_convergence(plane_index, ii, field, false);
    vel_tx(mm,:) = xsec;
end

% save data
time = get_output_times('Data2d');
slice_name = sprintf('/xz%d/y', plane_index);
yslice = h5read('Data2d_0.h5',slice_name);
filename = sprintf('radial_%s_y%2.0f', field, yslice);
save(filename,'plane_index','field','time','x','vel_tx');
