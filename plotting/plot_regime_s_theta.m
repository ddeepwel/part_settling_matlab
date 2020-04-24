% plot the minimum separation distance

direc = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/compare_data';
cd(direc)

style = 'sep';
gamm_np = 'gamm09';

switch style
    case 'sep'
        load(['min_sep_',gamm_np,'.mat'])
        min_sep = min_sep - 1; % remove the particle radii
        data = min_sep;
        c1 = 1;
        c2 = 2.8;
        leg_lab = {'$\tilde{s}<1$','$1\le \tilde{s}<2.8$','$\tilde{s}\ge2.8$'};
        fname = ['sep_s_theta_',gamm_np];
    case 'settling'
        load(['min_settling_',gamm_np,'.mat'])
        data = min_settling_vel;
        c1 = -1;
        c2 = -0.85;
        leg_lab = {'$w_c/w_s<-1$','$-1\le w_c/w_s<-0.85$','$w_c/w_s\ge-0.85$'};
        fname = ['settling_vel_s_theta_',gamm_np];
    case 'entrain'
        load(['max_entrain_',gamm_np,'.mat'])
        data = max_entrain;
        c1 = 15;
        c2 = 17;
        leg_lab = {'$V<15$','$15\le V<17$','$V\ge17$'};
        %fname = ['entrain_s_theta_',gamm_np];
        fname = ['entrain_s_theta_',gamm_np];
end
[Ns, Ntheta] = size(data);
ss = ss-1; % subtract the particle radii

figure(88)
clf

cols = default_line_colours();
for mm = 1:Ns
    for nn = 1:Ntheta
        if data(mm,nn) < c1
            %p1 = plot(thetas(nn),ss(mm),'o','Color',cols(1,:));
            p1 = polarplot(pi/2 - thetas(nn)/180*pi, ss(mm),'o','Color',cols(1,:));
            p = p1;
        elseif data(mm,nn) < c2
            %p2 = plot(thetas(nn),ss(mm),'^','Color',cols(2,:));
            p2 = polarplot(pi/2 - thetas(nn)/180*pi, ss(mm),'^','Color',cols(2,:));
            p = p2;
        elseif data(mm,nn) >= c2
            %p3 = plot(thetas(nn),ss(mm),'s','Color',cols(3,:));
            p3 = polarplot(pi/2 - thetas(nn)/180*pi, ss(mm),'s','Color',cols(3,:));
            p = p3;
        end
        if mm == 1 && nn == 1
            hold on
        end
        if near_bottom(mm,nn) == 1
            %plot(thetas(nn),ss(mm),'kx');
            polarplot(pi/2 - thetas(nn)/180*pi,ss(mm),'kx');
        end
        p.MarkerFaceColor = p.Color;
        p.MarkerSize = 10;
    end
end
%axis([-10 100 0 6])
axis([0 90 0 6])

%xlabel('$\theta~(^\circ)$')
%ylabel('$(s-D_p)/D_p$')
ax = gca;
ax.RAxis.Label.String = '$(s-D_p)/D_p$';
ax.ThetaAxis.Label.String = '$\theta~(^\circ)$';
leg = legend([p1 p2 p3],leg_lab);
leg.Location = 'EastOutside';

figure_defaults()
cd('../figures')
print_figure(fname,'format','pdf','size',[6 4])

