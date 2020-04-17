% make a plot of the evolution of the settling

base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
cases = {'gamm0.9/s2_th0','gamm0.9/s2_th67.5','gamm0.5/s2_th67.5'};

Ncases = length(cases);
Nt = 2;

levels0 = linspace(0.01,0.99,51);

figure(195)
clf

for mm = 1:Ncases
    cd([base,cases{mm}])
    par = read_params();
    yc = par.pyc_location;

    [~, ~, ~, ~, xy_p_0] = plot_stat2d('xy', 'c0', 0);
    for ii = 1:Nt
        if ii == 1;
            entr = load('entrained_fluid');
            [~,tind] = max(entr.volume);
            time = entr.time(tind);
        else
            time = 30;
        end
        time_2d = get_output_times('Data2d');
        tind = nearest_index(time_2d, time);

        [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy', 'c0', tind);
        min_data = min(data(:));
        max_data = max(data(:));
        levels = [min_data levels0 max_data];

        figure(195)
        subplot(Nt,Ncases,(ii-1)*Ncases + mm )
        hold on
        contourf(xvar, yvar, data'.*(1-vf'),levels);
        for nn = 1:size(xy_p,1)
            viscircles(xy_p(nn,:), 0.5, 'Color', [0 0 0], 'LineWidth', 1);
            viscircles(xy_p_0(nn,:), 0.5, 'LineStyle', '--', 'Color', [0 0 0], 'LineWidth', 1);
        end
        %contour(xvar, yvar, data'.*(1-vf'),[1 1]*0.5,'w');
        plot(xlim(), [1 1]*yc,'k-')
        plot(xlim(), [1 1]*yc,'w--')

        yticks(0:10:30)
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
        %if ii == 1
        %    ylim([15 30])
        %else
            ylim([0 30])
        %end
        shift_axis((2-mm)*0.05, (ii-1.5)*0.08)
        set(gca,'TickDir','out');
        ttl = sprintf('%s $t/\\tau = %4.2f$',subplot_labels((ii-1)*Ncases+mm),time);
        text(0.0,1.06,ttl,'units','normalized')
    end
end

pos = get(gca,'Position');

figure_defaults()
colormap(cmocean('tempo'))

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('snapshots');
print_figure(fname,'format','jpeg','size',[6 8],'res',600)
