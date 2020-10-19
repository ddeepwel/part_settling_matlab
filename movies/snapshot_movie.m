% make a frame of a snapshot of the settling
clear all

base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
cases = {'gamm0.9/s2_th0_dx30','gamm0.9/s2_th67.5_dx25','gamm0.5/s2_th67.5_dx25'};

Ncases = length(cases);

levels0 = linspace(0.01,0.99,51);

figure(195)
clf

ts = 0:0.25:27;
Nts = length(ts);

cd([base,cases{end}])
check_make_dir('tmp_figs')

time_2d = cell(1,3);
xy_p_0  = cell(1,3);

for jj = 1:Nts
    for mm = 1:Ncases
        cd([base,cases{mm}])
        if jj == 1
            par(mm) = read_params();
            yc(mm) = par(mm).pyc_location;
            time_2d{mm} = get_output_times('Data2d');
            [~, ~, ~, ~, xy_p_00] = plot_stat2d('xy', 'c0', 0);
            xy_p_0{mm} = xy_p_00;
        end

        tind = nearest_index(time_2d{mm}, ts(jj));
        ff = sprintf('Data2d_%d.h5',tind-1);
        time = h5read(ff,'/time');

        [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy', 'c0', tind-1);
        min_data = min(data(:));
        max_data = max(data(:));
        levels = [min_data levels0 max_data];

        figure(195)
        ax = subplot(1,Ncases,mm);
        hold on
        contourf(xvar, yvar-yc(mm), data'.*(1-vf'),levels);
        for nn = 1:size(xy_p,1)
            viscircles(xy_p_0{mm}(nn,:)-[0 yc(mm)], 0.5, 'LineStyle', ':', 'Color', [0 0 0], 'LineWidth', 1);
        end
        for nn = 1:size(xy_p,1)
            viscircles(xy_p(nn,:)-[0 yc(mm)], 0.5, 'Color', [0 0 0], 'LineWidth', 1);
        end
        plot([-6 6],[1 1]*(30-yc(mm)),'k')
        %contour(xvar, yvar, data'.*(1-vf'),[1 1]*0.5,'w');
        %plot(xlim(), [1 1]*yc(mm),'k-')
        %plot(xlim(), [1 1]*yc(mm),'w--')

        %yticks(0:10:30)
        if mm > 1
            yticklabels([])
        else
            ylabel('$z/D_p$')
        end
        xlabel('$x/D_p$')
        axis image
        xlim([-6 6])
        ylim([-22 8])
        shift_axis((2-mm)*0.025-0.05, 0.02)
        set(gca,'XMinorTick','off','YMinorTick','on')
        ax.YAxis.MinorTickValues = -25:2.5:10;
        ax.TickLength = [0.015 0.035];
        set(gca,'TickDir','out');
        %text(0.1,1+(0.08/ii),subplot_labels((ii-1)*Ncases+mm),'units','normalized')
        caxis([0 1])

        if mm == 2
            ttl = sprintf('$t/\\tau = %0.2f$',time);
            title(ttl)
        end
    end

    pos = get(gca,'Position');
    cbar = colorbar('EastOutside');
    set(gca,'Position',pos);
    bot = pos(2)+pos(4)/2 - 0.35/2;
    cbpos = cbar.Position;
    cbpos = [0.86 bot 0.025 0.35];
    cbar.Position = cbpos;
    cbar.Label.String = '$\rho''$';

    figure_defaults()
    colormap(cmocean('tempo'))


    % save output figure
    cd('tmp_figs')
    filename = ['tmp_',num2str(jj,'%03d')];
    print_figure(filename, 'format', 'png','size', [6 4],'res',600)
    cd('..')

    completion(jj, Nts)
end

first_out = 1;
check_make_dir('../movies')
filename = 'snapshots';
framerate = 6;
ffmpeg = sprintf(['ffmpeg -framerate %d -r %d '...
    '-start_number %d -i tmp_%%03d.png -q 1 -vcodec mpeg4 '...
    '../movies/%s.mp4'], framerate, framerate,first_out,filename);
fprintf([ffmpeg,'\n'])
status = system(ffmpeg);
if status ~= 0
    disp([filename,'.mp4 was possibly not redered correctly.'])
end
cd('..')
%rmdir('tmp_figs','s')


