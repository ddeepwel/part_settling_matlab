% plot the vertical velocity above a single particle
% this is to show how the stratification changes the velocity structure


base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/';
gamm_dirs = {
'gamm0.1',...
'gamm0.3',...
'gamm0.5',...
'gamm0.7',...
'gamm0.9',...
'gamm1.0'
};
gs = [0.1:0.2:0.9, 1.0];

depth = 21;
% 24 is the location of the pycnocline

figure(75)
clf
figure(76)
clf
hold on

for mm = 1:length(gs)
    cd([base,gamm_dirs{mm},'/1prt_dx25'])

    % find time for particle at prescribed depth 
    time = get_output_times('Data2d');
    [t_p1, y_p1, v_p1] = settling();
    t_p_ind = nearest_index(y_p1, depth);
    t_m_ind = nearest_index(time, t_p1(t_p_ind));
    t_actual(mm) = time(t_m_ind);
    ii = t_m_ind;

    t_actual_p_ind = nearest_index(t_p1, t_actual);
    y_actual = y_p1(t_actual_p_ind);

    % plot 2D structure
    [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy','c0',ii);
    [cx05, cy05]  = find_contour(xvar,yvar,data'.*(1-vf'),0.5);
    [cx075,cy075] = find_contour(xvar,yvar,data'.*(1-vf'),0.75);
    [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy','v',ii);
    [nx,ny] = size(data);
    figure(75)
    subplot(2,3,mm)
    pcolor(xvar,yvar,data'.*(1-vf'))
    hold on
    if mm ~= 6
        plot(cx05, cy05,'k')
        plot(cx075,cy075,'k')
    end
    plot([1 1]*-1,[15 25],'k--')
    plot([1 1]* 1,[15 25],'k--')
    pos = get(gca,'Position');
    if mm <= 3
        xticklabels([])
    else
        xlabel('$x/D_p$')
    end
    if ((mm == 1) || (mm == 4))
        ylabel('$z/D_p$')
    else
        yticklabels([])
    end
    shading flat
    axis image
    ylim([15 25])
    cb = colorbar;
    %cb.Label.Interpreter = 'latex';
    %cb.Label.String = '$w/w_s$';
    mx = max(abs(data(:)));
    caxis([-1 1]*mx)
    title(sprintf('$\\Gamma = %0.2g$',1-gs(mm)))
    text(gca,0.15,0.15,subplot_labels(mm),...
            'Color','k','Units','normalized','Interpreter','Latex')


    % plot 1D structure
    figure(76)
    plot(data(round(nx/2),:).*(1-vf(round(nx/2),:)),yvar)
    gs2{mm} = sprintf('$\\Gamma = %0.2g$',1-gs(mm));
    max_vel(mm) = max(data(round(nx/2),:).*(1-vf(round(nx/2),:)));
end

leg = legend(gs2);
leg.Location = 'best';
ylim([15 30])
figure_defaults()

figure(75)
figure_defaults()
colormap(cmocean('balance'))
for mm = 1:length(gs)
    subplot(2,3,mm)
    shift_axis(0.06*(1-mod(mm-1,3)),0);
    if mm <= 3
        shift_axis(0,-0.03);
    else
        shift_axis(0,0.03);
    end
end

cd('../../figures')
%print_figure('vertvel_gamm','format','jpeg','size',[10 4])
