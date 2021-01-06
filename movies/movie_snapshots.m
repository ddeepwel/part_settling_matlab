% make a series of plots of the evolution of the settling
clear all

base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
cases = {'gamm0.9/s2_th0_dx30','gamm0.9/s2_th67.5_dx25','gamm0.5/s2_th67.5'};

cd([base,cases{1}])
N1 = last_output('Data2d');
cd([base,cases{2}])
N2 = last_output('Data2d');
cd([base,cases{3}])
N3 = last_output('Data2d');
Nout = min([N1 N2 N3]);

Ncases = length(cases);

levels0 = linspace(0.01,0.99,51);

figure(196)
clf

for ii = 0:Nout
    for mm = 1:Ncases
        cd([base,cases{mm}])
        par = read_params();
        yc = par.pyc_location;

        % read initial particle location
        [~, ~, ~, ~, xy_p_0] = plot_stat2d('xy', 'c0', 0);
        ff = sprintf('Data2d_%d.h5',ii);
        time = h5read(ff,'/time');

        % read current particle location
        [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy', 'c0', ii);
        min_data = min(data(:));
        max_data = max(data(:));
        levels = [min_data levels0 max_data];

        figure(196)
        ax = subplot(1, Ncases, mm);
        hold on
        contourf(xvar, yvar-yc, data'.*(1-vf'),levels);
        for nn = 1:size(xy_p,1)
            viscircles(xy_p_0(nn,:)-[0 yc], 0.5, 'LineStyle', ':', 'Color', [0 0 0], 'LineWidth', 1);
            viscircles(xy_p(nn,:)-[0 yc], 0.5, 'Color', [0 0 0], 'LineWidth', 1);
        end
        plot([-6 6],[1 1]*(30-yc),'k')

        % make pretty
        if mm > 1
            yticklabels([])
        else
            ylabel('$z/D_p$')
        end
        xlabel('$x/D_p$')
        axis image
        xlim([-6 6])
        ylim([-22 8])
        shift_axis((2-mm)*0.03-0.02, 0);%(ii-1.5)*0.1)
        set(gca,'XMinorTick','off','YMinorTick','on')
        ax.YAxis.MinorTickValues = -25:2.5:10;
        ax.TickLength = [0.015 0.035];
        set(gca,'TickDir','out');
        ttl = sprintf('$t/\\tau = %4.2f$',time);
        if mm == 2
            title(ttl)
        end
        caxis([0 1])
    end

    % colorbar
    %pos = get(gca,'Position');
    cbar = colorbar('EastOutside');
    %set(gca,'Position',pos);
    cbpos = cbar.Position;
    cbpos = [0.88 0.33 0.025 0.35];
    cbar.Position = cbpos;
    cbar.Label.String = '$\rho''$';

    figure_defaults()
    colormap(cmocean('tempo'))

    % save
    check_make_dir('../../movies/tmp')
    cd('../../movies/tmp')
    fname = sprintf('tmp_%03d');
    fname = ['tmp_',num2str(ii,'%03d')];
    print_figure(fname,'format','png','size',[6 6],'res',600)

    completion(ii,Nout)
end

first_out = 1;
filename = 'snapshots';
framerate = 6;
ffmpeg = sprintf(['ffmpeg -framerate %d -r %d '...
    '-start_number %d -i tmp_%%03d.png -q 1 -vcodec mpeg4 '...
    '../%s.mp4'], framerate, framerate,first_out,filename);
fprintf([ffmpeg,'\n'])
status = system(ffmpeg);
if status ~= 0
    disp([filename,'.mp4 was possibly not redered correctly.'])
end
cd('..')
