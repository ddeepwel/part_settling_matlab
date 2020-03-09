% make a comparison plot of the vertical velocity above/below the particle settling

figure(76)
clf

load('xsection_vert_00')

pcolor(time,y,v_ty');
shading interp
caxis([-1 1]*0.5)
ylabel('$y/D_p$')
xlim([0 60])
xlabel('$t$')


colormap(cmocean('balance'))
figure_defaults
check_make_dir('figures')
cd('figures')
print_figure('vertical_velocity_through_particle','size',[6 4],'format','jpeg')
cd('..')
