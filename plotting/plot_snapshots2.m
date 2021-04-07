% make a plot of the evolution of the settling
clear all

base = '/Volumes/2part_settling/2particles/sigma1/Re1_4/';
cases = {'gamm0.9/s2_th0_dx30','gamm0.9/s2_th67.5_dx25','gamm0.5/s2_th67.5'};

Ncases = length(cases);
times = [6 30];
Nt = length(times);

levels0 = linspace(0.01,0.99,51);

figure(195)
clf

for mm = 1:Ncases
    cd([base,cases{mm}])
    par = read_params();
    yc = par.pyc_location;

    [~, ~, ~, ~, xy_p_0] = plot_stat2d('xy', 'c0', 0);
    for ii = 1:Nt
        %if ii == 1;
        %    entr = load('entrained_fluid');
        %    [~,tind] = max(entr.volume);
        %    time = entr.time(tind);
        %else
        %    time = 30;
        %end
        time_2d = get_output_times('Data2d');
        tind = nearest_index(time_2d, times(ii));
        ff = sprintf('Data2d_%d.h5',tind-1);
        time = h5read(ff,'/time');

        [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy', 'c0', tind-1);
        min_data = min(data(:));
        max_data = max(data(:));
        levels = [min_data levels0 max_data];

        figure(195)
        ax = subplot(Nt,Ncases,(ii-1)*Ncases + mm );
        hold on
        contourf(xvar, yvar-yc, data'.*(1-vf'),levels);
        for nn = 1:size(xy_p,1)
            viscircles(xy_p(nn,:)-[0 yc], 0.5, 'Color', [0 0 0], 'LineWidth', 1);
            viscircles(xy_p_0(nn,:)-[0 yc], 0.5, 'LineStyle', ':', 'Color', [0 0 0], 'LineWidth', 1);
        end
        plot([-6 6],[1 1]*(30-yc),'k')
        %contour(xvar, yvar, data'.*(1-vf'),[1 1]*0.5,'w');
        %plot(xlim(), [1 1]*yc,'k-')
        %plot(xlim(), [1 1]*yc,'w--')

        %yticks(0:10:30)
        if mm > 1
            yticklabels([])
        else
            ylabel('$z/D_p$')
        end
        if ii == 1
            xticklabels([])
        else
            xlabel('$x/D_p$')
        end
        axis image
        xlim([-6 6])
        if ii == 1
            pos = get(gca,'Position');
            ylim([-7 8])
            pos(4) = pos(4)/2;
            set(gca,'Position',pos);
        else
            ylim([-22 8])
        end
        shift_axis((2-mm)*0.05, (ii-1.5)*0.1)
        set(gca,'XMinorTick','off','YMinorTick','on')
        if ii == 1
            ax.YAxis.MinorTickValues = -10:2.5:10;
            ax.TickLength = [0.03 0.07];
        else
            ax.YAxis.MinorTickValues = -25:2.5:10;
            ax.TickLength = [0.015 0.035];
        end
        set(gca,'TickDir','out');
        %ttl = sprintf('%s $t/\\tau = %4.2f$',subplot_labels((ii-1)*Ncases+mm),time);
        text(0.1,1+(0.08/ii),subplot_labels((ii-1)*Ncases+mm),'units','normalized')
        caxis([0 1])
    end
end

pos = get(gca,'Position');
cbar = colorbar('EastOutside');
set(gca,'Position',pos);
cbpos = cbar.Position;
cbpos = [0.86 0.26 0.025 0.35];
cbar.Position = cbpos;
cbar.Label.String = '$\rho''$';

figure_defaults()
colormap(cmocean('tempo'))

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('snapshots2');
print_figure(fname,'format','jpeg','size',[6 8],'res',600)
