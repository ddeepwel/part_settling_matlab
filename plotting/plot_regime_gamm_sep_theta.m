% plot the minimum separation distance

direc = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/compare_data';
cd(direc)

figure(88)
clf

style = 'entrain_mass_dist';
%style = 'sep';

switch style
    case 'sep'
        load('min_sep_s2.mat')
        min_sep = min_sep - 1; % remove the particle radii
        data = min_sep*100;
        data(data<0) = 0;
        fname = 'sep_gamm_theta';
        c1 = 5;
        c2 = 15;
        c3 = 40;
        clim = [0 100];
    case 'settling'
        load('min_settling_s2.mat')
        data = min_settling_vel;
        fname = 'settling_vel_gamm_theta';
    case 'entrain'
        load('max_entrain_s2.mat')
        data = max_entrain;
        fname = 'entrain_gamm_theta';
    case 'entrain_mass'
        load('entrain_final_s2.mat')
        data = entrain_final;
        fname = 'entrain_final_gamm_sep_theta';
    case 'entrain_mass_dist'
        load('entrain_dist_s2.mat')
        data = entrain_dist;
        orig_dir = pwd;
        g1 = 0.9:-0.2:0.1;
        suffix = {...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            };
        clim = [1 1.40];
        for gg = 1:length(g1)
            cd(sprintf('../gamm%.1f/1prt%s',g1(gg),suffix{gg}));
            [data1,ent_dist] = get_entrain_mass_dist(dist);
            data(gg,:) = data(gg,:) / (2*data1);
            ent_dist1(gg) = ent_dist;
            cd(orig_dir)
        end
        fname = 'entrain_dist_gamm_sep_theta';
end
[Ngamms, Ntheta] = size(data);


%%%%%%  WARNING %%%%%
% changing data here
% but it is very minor
if strcmp(style,'entrain_mass_dist')
    data(data>clim(2)) = clim(2);
    data(data<clim(1)) = clim(1);
end

subplot(1,2,1)

cols = cmocean('-thermal');
for mm = 1:Ngamms-1
    for nn = 1:Ntheta
        col_row = round((data(mm,nn)-clim(1))/(clim(2)-clim(1))*255 + 1);
        %if (mm == 4 && nn > 3) || (mm==5 && (nn==2 || nn==3))
        %if (mm==5 && nn==2)
        %    continue
        %else
            p = plot(theta(nn),1-gamm(mm),'o','Color',cols(col_row,:));
        %end
        if mm == 1 && nn == 1
            hold on
        end
        switch style
            case 'entrain_mass'
                if need_longer(mm,nn) == 1
                    plot(theta(nn),1-gamm(mm),'kx');
                end
            case 'entrain_mass_dist'
                %if abs(dist - dist_meas(mm,nn)) > 1
                    %plot(theta(nn),1-gamm(mm),'kx');
                %end
                lab = sprintf('%0.1f',data(mm,nn));
            otherwise
                %if near_bottom(mm,nn) == 1
                %    plot(theta(nn),1-gamm(mm),'kx');
                %end
                lab = sprintf('%2.0f',data(mm,nn));
        end
        text(theta(nn), 1-gamm(mm)+0.04,lab,'HorizontalAlignment','center','VerticalAlignment','bottom');
        p.MarkerFaceColor = p.Color;
        p.MarkerSize = 10;
    end
end
switch style
    case 'sep'
        contour(theta, 1-gamm(1:end-1), data(1:end-1,:),[1 1]*c1,'k--')
        contour(theta, 1-gamm(1:end-1), data(1:end-1,:),[1 1]*c2,'k-')
        contour(theta, 1-gamm(1:end-1), data(1:end-1,:),[1 1]*c3,'k-.')
end

axis([-10 100 0 0.8])
xticks([0 45 90])
yticks(0.1:0.2:0.9)
set(gca,'XMinorTick','on');
ax = gca;
ax.XAxis.MinorTickValues = [22.5 67.5];
xlabel('$\theta~(^\circ)$')
ylabel('$\Gamma$')
xlab = -0.3;
zlab = 0.8;
text(gca,xlab,zlab,subplot_labels(1),...
    'Color','k','Units','normalized','Interpreter','Latex')


%%%%%%% subplot 2
subplot(1,2,2)

gamm_np = 'gamm09';

switch style
    case 'sep'
        load(['min_sep_',gamm_np,'.mat'])
        min_sep = min_sep - 1; % remove the particle radii
        data = min_sep ./ repmat(ss'-1,[1,5]);
        data = data * 100;
    case 'settling'
        load(['min_settling_',gamm_np,'.mat'])
        data = min_settling_vel;
    case 'entrain'
        load(['max_entrain_',gamm_np,'.mat'])
        data = max_entrain;
    case 'entrain_mass'
        load(['entrain_final_',gamm_np,'.mat'])
        data = entrain_final;
    case 'entrain_mass_dist'
        load(['entrain_dist_',gamm_np,'.mat'])
        data = entrain_dist;
        orig_dir = cd(['../',gamm_np(1:end-1),'.',gamm_np(end),'/1prt']);
        [data1,ent_dist] = get_entrain_mass_dist(dist);
        data = data / (2*data1);
        cd(orig_dir)
end
[Ns, Ntheta] = size(data);
ss = ss-1; % subtract the particle radii

%%%%%%  WARNING %%%%%
% changing data here
% but it is very minor
data
if strcmp(style,'entrain_mass_dist')
    data(data>clim(2)) = clim(2);
    data(data<clim(1)) = clim(1);
end


cols = cmocean('-thermal');
for mm = 1:Ns
    for nn = 1:Ntheta
        col_row = round((data(mm,nn)-clim(1))/(clim(2) - clim(1))*255 + 1);
        p = polarplot(pi/2 + thetas(nn)/180*pi, ss(mm),'o','Color',cols(col_row,:));
        if mm == 1 && nn == 1
            hold on
        end
        switch style
            case 'entrain_mass'
                if need_longer(mm,nn) == 1
                    polarplot(pi/2 + thetas(nn)/180*pi,ss(mm),'kx');
                end
            case 'entrain_mass_dist'
                %if abs(dist - dist_meas(mm,nn)) > 1
                %    polarplot(pi/2 + thetas(nn)/180*pi,ss(mm),'kx');
                %end
                lab = sprintf('%0.1f',data(mm,nn));
            otherwise
                %if near_bottom(mm,nn) == 1
                %    polarplot(pi/2 + thetas(nn)/180*pi,ss(mm),'kx');
                %end
                lab = sprintf('%2.0f',data(mm,nn));
        end
        if mm == 1
            if nn == 1
                text(pi/2 + thetas(nn)/180*pi, ss(mm)+0.4,lab,...
                    'HorizontalAlignment','center','VerticalAlignment','bottom');
            else
                text(pi/2 + thetas(nn)/180*pi, ss(mm)+0.4,lab,...
                    'HorizontalAlignment','right','VerticalAlignment','bottom');
            end
        else
            if nn == 1
                text(pi/2 + thetas(nn)/180*pi, ss(mm)+0.07,lab,...
                    'HorizontalAlignment','center','VerticalAlignment','bottom');
            else
                text(pi/2 + thetas(nn)/180*pi, ss(mm)+0.05,lab,...
                    'HorizontalAlignment','right','VerticalAlignment','bottom');
            end
        end
        p.MarkerFaceColor = p.Color;
        p.MarkerSize = 10;
    end
end
axis([90 180 0 8])

if strcmp(style,'entrain_mass_dist')
    phi = pi/2 - acos(0.5/8);
    polarplot(pi/2 + [pi/2 phi],[0.5 8],'k')
end

ax = gca;
ax.RAxis.Label.String = '$s_0/D_p$';
ax.ThetaAxis.Label.String = '$\theta~(^\circ)$';
ax.ThetaAxis.Label.Position = [125 9.5 0];
ax.ThetaAxis.TickValues = 90:30:180;
ax.ThetaAxis.TickLabel = {'0','30','60','90'};
xlab = 0.05;
zlab = 0.86;
text(gca,xlab,zlab,subplot_labels(2),...
    'Color','k','Units','normalized','Interpreter','Latex')

pos = get(gca,'position');
pos(1) = 0.52;
%pos(2) = 0.15;
set(gca, 'position', pos)

colormap(cmocean('-thermal'))
caxis(clim)
cbar = colorbar();
cbar.Location = 'EastOutside';
cbar.Label.Interpreter = 'latex';
if strcmp(style,'sep')
    cbar.Label.String = '$\min s/s_0 \times 100\%$';
end
pos = cbar.Position;
pos(1) = 0.89;
pos(2) = 0.15;
pos(4) = 0.7;
cbar.Position = pos;
if strcmp(style,'entrain_mass_dist')
    cbar.Ticks = 1:0.1:1.4;
end


figure_defaults()
cd('../figures')
print_figure(fname,'format','pdf','size',[9 4])

