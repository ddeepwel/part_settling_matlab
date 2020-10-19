% plot the minimum separation distance

direc = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/compare_data';
cd(direc)

style = 'entrain_mass';
%style = 'sep';

switch style
    case 'sep'
        load('min_sep_s2.mat')
        min_sep = min_sep - 1; % remove the particle radii
        data = min_sep;
        data(data<0) = 0;
        c1 = 0.05;
        c2 = 0.15;
        c3 = 0.4;
        %leg_lab = {'$\tilde{s}<0.15$','$0.15\le \tilde{s}<0.6$','$\tilde{s}\ge0.6$'};
        fname = 'sep_gamm_theta';
        %fname = 'sep_gamm_theta_radial';
    case 'settling'
        load('min_settling_s2.mat')
        data = min_settling_vel;
        %c1 = -1;
        %c2 = -0.9;
        %leg_lab = {'$w_c/w_s<-1$','$-1\le w_c/w_s<-0.85$','$w_c/w_s\ge-0.85$'};
        fname = 'settling_vel_gamm_theta';
        %fname = 'settling_vel_gamm_theta_radial';
    case 'entrain'
        load('max_entrain_s2.mat')
        data = max_entrain;
        %c1 = 5;
        %c2 = 10;
        %leg_lab = {'$V<5$','$5\le V<10$','$V\ge10$'};
        fname = 'entrain_gamm_theta';
        %fname = 'entrain_gamm_theta_radial';
    case 'entrain_mass'
        load('entrain_final_s2.mat')
        data = entrain_final;
        %c1 = 0.1;
        %c2 = 0.2;
        %leg_lab = {'$M<0.1$','$0.1\le M<0.2$','$M\ge0.2$'};
        fname = 'entrain_final_gamm_theta';
end
[Ngamms, Ntheta] = size(data);

figure(88)
clf

cols = cmocean('-thermal');
max_data = max(data(:));
min_data = min(data(:));
%cols = default_line_colours();
for mm = 1:Ngamms
    for nn = 1:Ntheta
        %if data(mm,nn) < c1
            col_row = round((data(mm,nn)-min_data)/(max_data-min_data)*255 + 1);
            p = plot(theta(nn),1-gamm(mm),'o','Color',cols(col_row,:));
            %p1 = polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'o','Color',cols(1,:));
        %    p = p1;
        %elseif data(mm,nn) < c2
        %    p2 = plot(theta(nn),gamm(mm),'^','Color',cols(2,:));
        %    %p2 = polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'^','Color',cols(2,:));
        %    p = p2;
        %else
        %    p3 = plot(theta(nn),gamm(mm),'s','Color',cols(3,:));
        %    %p3 = polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'s','Color',cols(3,:));
        %    p = p3;
        %end
        if mm == 1 && nn == 1
            hold on
        end
        lab = sprintf('%.2f',data(mm,nn));
        text(theta(nn), 1-gamm(mm)+0.04,lab,'HorizontalAlignment','center','VerticalAlignment','bottom');
        switch style
            case 'entrain_mass'
                if need_longer(mm,nn) == 1
                    plot(theta(nn),1-gamm(mm),'kx');
                    %polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'kx');
                end
            otherwise
                if near_bottom(mm,nn) == 1
                    plot(theta(nn),1-gamm(mm),'kx');
                    %polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'kx');
                end
        end
        p.MarkerFaceColor = p.Color;
        p.MarkerSize = 10;
    end
end
hold on
contour(theta, 1-gamm, data,[1 1]*c1,'k--')
contour(theta, 1-gamm, data,[1 1]*c2,'k-')
contour(theta, 1-gamm, data,[1 1]*c3,'k-.')

axis([-10 100 0 1])
xticks([0 45 90])
yticks(0.1:0.2:0.9)
set(gca,'XMinorTick','on');
ax = gca;
ax.XAxis.MinorTickValues = [22.5 67.5];

xlabel('$\theta~(^\circ)$')
ylabel('$\Gamma$')
%ax = gca;
%ax.RAxis.Label.String = '$\gamma$';
%ax.ThetaAxis.Label.String = '$\theta~(^\circ)$';
%leg = legend([p1 p2 p3],leg_lab);
%leg.Location = 'NorthOutside';

figure_defaults()
cd('../figures')
print_figure(fname,'format','pdf','size',[6 4])

