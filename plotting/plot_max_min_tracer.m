% plot the maximum tracer as a function of time

load('max_c0')

figure(78)
clf
subplot(2,1,1)
hold on
plot(time_3d,max_c0_3d-1)
plot(time_2d,max_c0_2d-1)
hold off
ylabel('$\rho_\mathrm{max}-1$','Interpreter','latex')

subplot(2,1,2)
hold on
plot(time_3d,min_c0_3d)
plot(time_2d,min_c0_2d)
ylabel('$\rho_\mathrm{min}$','Interpreter','latex')

xlabel('$t/\tau$')
leg=legend('Full field','$z=0$ cross-section');
leg.Location = 'NorthWest';
leg.Box = 'off';

figure_defaults();

check_make_dir('figures')
cd('figures')
print_figure('max_rho','format','pdf','size',[6 4])
cd('..')

