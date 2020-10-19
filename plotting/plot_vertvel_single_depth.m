% plot the vertical velocity above a single particle
% this is to show how the stratification changes the velocity structure


base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/';
gamm_dirs = {
'gamm1.0',...
'gamm0.9',...
'gamm0.7',...
'gamm0.5',...
'gamm0.3'
%'gamm0.1',...
};
gs = [1.0 0.9:-0.2:0.3];
mx = [0.9 0.6 0.4 0.2 0.1];

depth = 21;
% 24 is the location of the pycnocline

figure(75)
clf
figure(76)
clf
hold on
figure(77)
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
    [u, ~, ~, ~, ~]              = plot_stat2d('xy','u', ii);
    [cx05, cy05]  = find_contour(xvar,yvar,data'.*(1-vf'),0.5);
    [cx075,cy075] = find_contour(xvar,yvar,data'.*(1-vf'),0.75);
    [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy','v',ii);
    [nx,ny] = size(data);
    figure(75)
    if mm < 4
        ax = subplot(2,3,mm);
    else
        ax = subplot(2,3,mm+1);
    end
    pcolor(xvar,yvar-24,data'.*(1-vf'))
    hold on
    if mm ~= 1
        plot(cx05, cy05-24,'k')
        plot(cx075,cy075-24,'k')
    end
    plot([1 1]*-1,[-5 5],'k--')
    plot([1 1]* 1,[-5 5],'k--')
    %contour(xvar,yvar-24,u'.*(1-vf'),[1 1]*0,'g')
    if mm == 2 || mm == 3
        xticklabels([])
        xticks(-4:4)
    else
        xlabel('$x/D_p$')
    end
    if (mm == 1) %|| (mm == 3))
        ylabel('$z/D_p$')
    else
        yticklabels([])
    end
    shading flat
    axis image
    xlim([-4 4])
    ylim([-5 5])
    pos(mm,:) = ax.Position;
    set(gca,'XMinorTick','off','YMinorTick','on')
    ax.YAxis.MinorTickValues = [-2.5 2.5];
    cb = colorbar;
    cb.Ticks = [-mx(mm) 0 mx(mm)];
    %cb.Label.Interpreter = 'latex';
    %cb.Label.String = '$w/w_s$';
    %mx = max(abs(data(:)));
    caxis([-1 1]*mx(mm))
    title(sprintf('$\\Gamma = %0.2g$',1-gs(mm)))
    text(gca,0.09,0.82,subplot_labels(mm),...
            'Color','k','Units','normalized','Interpreter','Latex')


    % plot 1D structure
    figure(76)
    plot(data(round(nx/2),:).*(1-vf(round(nx/2),:)),yvar-24)
    gs2{mm} = sprintf('$\\Gamma = %0.2g$',1-gs(mm));
    w_mid = data(round(nx/2),:).*(1-vf(round(nx/2),:));

    Dmat = FiniteDiff(yvar,1,2);
    w_z = Dmat*w_mid';
    figure(77)
    plot(w_z,yvar-24)

    %keyboard
    %[max_vel(mm), indy] = max(w_mid);
    %Dmat = FiniteDiff(yvar,1,2);
    %w_z = Dmat*w_mid';
    %ind = nearest_index(yvar,21);
    %[max_wz,indy] = max(w_z(ind:end));
    %indy = ind+indy-1;
    %yp = yvar(indy)-24;
    %[max_u,indx] = max(u(:,indy));
    %xp = xvar(indx);
    %arrow3([xp yp],[xp+max_u yp],'k',1, 2)



    % plot horizontal convergences on 2D plot
    %[max_u,indx] = max(u(:,ind).*(1-vf(:,ind)));
    %annotation('arrow',[0 max_u*5]+xvar(indx), [1 1]*yvar(indy))
end

leg = legend(gs2);
leg.Location = 'best';
ylim([-5 5])
figure_defaults()

figure(76)
leg = legend(gs2);
leg.Location = 'best';
ylim([-5 5])
figure_defaults()

figure(75)
figure_defaults()
colormap(cmocean('balance'))
for mm = 1:6
    if mm == 4
        continue
    elseif mm == 1
        subplot(2,3,mm)
        H = pos(5,4);
        b2 = pos(2,2);
        t4 = pos(4,4) + pos(4,2);
        mid = (b2+t4)/2;
        shift = mid - H/2 - pos(5,2);
        shift_axis(0.06*(1-mod(mm-1,3)),-shift);
    else
        subplot(2,3,mm)
        shift_axis(0.06*(1-mod(mm-1,3)),0);
        if mm <= 3
            shift_axis(0,-0.03);
        else
            shift_axis(0,0.03);
        end
    end
end

cd('../../figures')
print_figure('vertvel_gamm','format','jpeg','size',[8 4])
