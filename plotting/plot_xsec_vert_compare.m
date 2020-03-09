% make a comparison plot of the vertical velocity above/below the particle settling

base = '/project/6001470/ddeepwel/part_settling/1particle/thick_strat/Ri0.5/';
cases = {...%'sigma10/try1',...
        'Re10',...
        'Re5',...
        'Re2.5',...
        'Re1',...
        'Re0.5',...
        'Re0.25'};

Ncases = length(cases);

figure(77)
clf

Re = [10 5 2.5 1 0.5 0.25];

for nn = 1:Ncases
    cd([base,cases{nn}])
    load('xsection_vert_00')

    ax = subplot(6,1,nn);
    pcolor(time,y,v_ty');
    shading interp
    caxis([-1 1]*0.5)
    ylabel('$y/D_p$')
    xlim([0 60])
    if nn == 1
        pos = ax.Position;
        cbar = colorbar('NorthOutside');
        cbar.Label.String = '$v/w_s$';
        ax.Position = pos;
    end
    if nn == Ncases
        xlabel('$t$')
    else
        xticklabels([])
    end
    title(sprintf('$Re=%2.2g$',Re(nn)),'Interpreter','Latex')
end


colormap(cmocean('balance'))
figure_defaults
cd('../figures')
print_figure('vertical_velocity_through_particle','size',[5 12],'format','jpeg')
