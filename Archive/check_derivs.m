% check the rho gradient diagnostic by comparing
% the value computed in parties to that from the gradients in matlab


ii = 1;

% load data
filename_2d = sprintf('Data2d_%d.h5',ii);
rho_x = h5read(filename_2d, '/grad_x_c_full');
rho_y = h5read(filename_2d, '/grad_y_c_full');
rho_z = h5read(filename_2d, '/grad_z_c_full');

data = rho_x;
data = squeeze(sum(data,2));

filename_3d = sprintf('Data_%d.h5',ii);
x = h5read(filename_3d, '/grid/xc');
y = h5read(filename_3d, '/grid/yc');
z = h5read(filename_3d, '/grid/zc');

% upper and lower terms
%rho_u = squeeze(sum(sqrt(rho_x.^2 +            rho_z.^2),2));
%rho_l = squeeze(sum(sqrt(rho_x.^2 + rho_y.^2 + rho_z.^2),2));

%rho_diag = rho_u ./ rho_l;

% load the diagnostic from parties
rho_dp = h5read(filename_2d, '/c_curve_diag');


% print out useful information
max_dp = max(abs(rho_dp(:)));
max_diag = max(abs(data(:)));
fprintf('max abs from parties:   %0.3g\n', max_dp);
fprintf('max abs from gradients: %0.3g\n', max_diag);
fprintf('ratio:                  %0.3g\n', max_diag / max_dp);


figure(98)
clf
subplot(3,1,1)
pcolor(x,z,rho_dp')
shading flat
colorbar
title('from diagnostic')

subplot(3,1,2)
pcolor(x,z,data')
shading flat
colorbar
title('from gradients')

ax3 = subplot(3,1,3);
diff_d = rho_dp' - data';
pcolor(x,z,diff_d)
shading flat
colorbar
title('diff')
colormap(cmocean('balance'))
caxis([-1 1]*max(abs(diff_d(:))))

figure_defaults()

