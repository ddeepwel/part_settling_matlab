
figure(65)
clf
plot_settling(0);
plot_settling(1);

check_make_dir('figures')
cd('figures')
print_figure('settling','format','pdf','size',[6 4]);
cd('..')
