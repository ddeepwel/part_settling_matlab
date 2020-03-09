% make a comparison plot between two different cases


base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/rho_s2.0/Ri40/Re0.25/';
cases = {'D2_th90_highPe','D2_th90_true_highPe'};
lab = {'$Pe = 100$','$Pe = 500$'};

ii = 40;

ax = [-4 6 45 55];


figure(101)
clf
hold on

for mm = 1:2
    cd([base,cases{mm}])
    %gd = read_grid('Data2d_0.h5');
    [dat0, ~, ~,    ~]    = plot_stat2d('xy','c0',0);
    [dat, vf, xvar, yvar] = plot_stat2d('xy','c0',ii);

    figure(101)
    ax12 = subplot(2,2,mm);
    pcolor(xvar, yvar, dat'.*(1-vf'))
    shading  flat
    axis equal
    axis(ax)
    xlabel('$x/D_p$')
    ylabel('$y/D_p$')
    set(gca,'TickDir','out');
    %ttl = sprintf('$t=%d$',ii);
    %ttl = sprintf('%s',cases{mm});
    ttl = sprintf('%s',lab{mm});
    title(ttl)
    colormap(ax12,cmocean('tempo'))


    ax34 = subplot(2,2,mm+2);
    pcolor(xvar, yvar, (dat' - dat0').*(1-vf'))
    shading flat
    axis equal
    axis(ax)
    xlabel('$x/D_p$')
    ylabel('$y/D_p$')
    set(gca,'TickDir','out');
    title('$\rho - \rho_0$')
    colormap(ax34,cmocean('balance'))
    caxis([-1 1]*0.5)
end 

figure_defaults()

cd('../figures')
print_figure('Pe_comparison_snapshot_t40','size',[10 10],'res',500)
