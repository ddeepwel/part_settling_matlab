% plot the minimum separation distance

direc = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/compare_data';
cd(direc)

style = 'sep';

switch style
    case 'sep'
        load('min_sep_s2.mat')
        min_sep = min_sep - 1; % remove the particle radii
        data = min_sep;
        c1 = 0.15;
        c2 = 0.6;
        leg_lab = {'$\tilde{s}<0.15$','$0.15\le \tilde{s}<0.6$','$\tilde{s}\ge0.6$'};
        fname = 'sep_gamm_theta';
        %fname = 'sep_gamm_theta_radial';
    case 'settling'
        load('min_settling_s2.mat')
        data = min_settling_vel;
        c1 = -1;
        c2 = -0.9;
        leg_lab = {'$w_c/w_s<-1$','$-1\le w_c/w_s<-0.85$','$w_c/w_s\ge-0.85$'};
        fname = 'settling_vel_gamm_theta';
        %fname = 'settling_vel_gamm_theta_radial';
    case 'entrain'
        load('max_entrain_s2.mat')
        data = max_entrain;
        c1 = 5;
        c2 = 10;
        leg_lab = {'$V<5$','$5\le V<10$','$V\ge10$'};
        fname = 'entrain_gamm_theta';
        %fname = 'entrain_gamm_theta_radial';
end
[Ngamms, Ntheta] = size(data);

figure(88)
clf

cols = default_line_colours();
for mm = 1:Ngamms
    for nn = 1:Ntheta
        if data(mm,nn) < c1
            p1 = plot(theta(nn),gamm(mm),'o','Color',cols(1,:));
            %p1 = polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'o','Color',cols(1,:));
            p = p1;
        elseif data(mm,nn) < c2
            p2 = plot(theta(nn),gamm(mm),'^','Color',cols(2,:));
            %p2 = polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'^','Color',cols(2,:));
            p = p2;
        else
            p3 = plot(theta(nn),gamm(mm),'s','Color',cols(3,:));
            %p3 = polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'s','Color',cols(3,:));
            p = p3;
        end
        if mm == 1 && nn == 1
            hold on
        end
        if near_bottom(mm,nn) == 1
            plot(theta(nn),gamm(mm),'kx');
            %polarplot(pi/2 - theta(nn)/180*pi,gamm(mm),'kx');
        end
        p.MarkerFaceColor = p.Color;
        p.MarkerSize = 10;
    end
end
axis([-10 100 0 1])
%axis([0 90 0 1])

xlabel('$\theta~(^\circ)$')
ylabel('$\gamma$')
%ax = gca;
%ax.RAxis.Label.String = '$\gamma$';
%ax.ThetaAxis.Label.String = '$\theta~(^\circ)$';
leg = legend([p1 p2 p3],leg_lab);
leg.Location = 'NorthOutside';

figure_defaults()
cd('../figures')
print_figure(fname,'format','pdf','size',[6 4])

