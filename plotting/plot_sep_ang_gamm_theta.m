% compare the particle settling for different stratifications (gamma)
% and particle orientation angle (theta)

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist = 's2_th0';
cases1 = {...
    'gamm1.0',...
    'gamm0.9',...
    'gamm0.7',...
    'gamm0.5',...
    ...%'gamm0.3',...
    'gamm0.1',...
    };
labs1 = {...
    '$\Gamma = 0.0$',...
    '$\Gamma = 0.1$',...
    '$\Gamma = 0.3$',...
    '$\Gamma = 0.5$',...
    ...%'$\Gamma = 0.7$',...
    '$\Gamma = 0.9$',...
    };
suffix = {...
    '_entr_tall',...
    '_entr',...
    '_entr',...
    '_entr',...
    ...%'_entr',...
    '_entr',...
    };

gamm = 'gamm0.9';
cases2 = {...
    's2_th0_entr',...
    's2_th22.5_entr',...
    ...%'s2_th45_dx25',...
    's2_th67.5_entr',...
    's2_th90_entr',...
    };
labs2 = {...
    '$\theta = 0^\circ$',...
    '$\theta = 22.5^\circ$',...
    ...%'$\theta = 45^\circ$',...
    '$\theta = 67.5^\circ$',...
    '$\theta = 90^\circ$',...
    };

figure(165)
clf

cols = default_line_colours();

for mm = 1:length(cases1)
    cd([base,cases1{mm},'/',angle_dist,suffix{mm}])
    [time, sep, sep_vel] = particle_separation();
    [time, thet] = particle_angle();
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end

    subplot(2,2,1)
    hold on
    if strcmp(cases1{mm}, 'gamm1.0')
        p1(mm) = plot(time(inds), sep(inds)-1, 'k');
    else
        p1(mm) = plot(time(inds), sep(inds)-1, 'Color', cols(mm-1,:));
    end
    xlim([0 60])
    ylim([0 3])
    xticklabels([])
    %yticks(0:4)
    %yticklabels([0 {''} 2 {''} 4])
    set(gca,'TickLength',[0.02 0.05]);
    xlab = -0.25;
    zlab = 0.94;
    if mm == length(mm)
        ylabel('$s/D_p$')
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 10:20:50;
        ax.YAxis.MinorTickValues = 0.5:1:2.5;
        text(gca,6,0,'*','VerticalAlignment','top');
        text(gca,xlab,zlab,subplot_labels(1),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end

    subplot(2,2,3)
    hold on
    if strcmp(cases1{mm}, 'gamm1.0')
        %p3(mm) = plot(time(inds), (abs(thet(inds)) - thet(1)) / (90 - thet(1)), 'k');
        p3(mm) = plot(time(inds), abs(thet(inds)), 'k');
    else
        %p3(mm) = plot(time(inds), (abs(thet(inds)) - thet(1)) / (90 - thet(1)), 'Color', cols(mm-1,:));
        p3(mm) = plot(time(inds), abs(thet(inds)), 'Color', cols(mm-1,:));
    end
    %plot([0 100],[0 0],'Color',[1 1 1]*0.5)
    xlim([0 60])
    %ylim([-0.4 0.2])
    set(gca,'TickLength',[0.02 0.05]);
    xlab = -0.25;
    zlab = 0.94;
    if mm == length(mm)
        xlabel('$t/\tau$')
        %ylabel('$(\theta-\theta_0)/(90-\theta_0)$','Interpreter','latex')
        ylabel('$\theta$~$(^\circ)$','Interpreter','latex')
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 10:20:50;
        %ax.YAxis.MinorTickValues = -0.3:0.2:0.1;
        text(gca,6,-0.4,'*','VerticalAlignment','top');
        text(gca,xlab,zlab,subplot_labels(3),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end
end

leg = legend(p3, labs1);
leg.Location = 'SouthEast';
leg.Box = 'off';
leg.NumColumns = 2;
xshift = 0.03;
zshift = 0.017;
shift_axis(xshift,+zshift)
subplot(2,2,1)
shift_axis(xshift,-zshift)

for mm = 1:length(cases2)
    cd([base,gamm,'/',cases2{mm}])
    [time, sep, sep_vel] = particle_separation();
    [time, thet] = particle_angle();
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end

    subplot(2,2,2)
    hold on
    if mod(mm,2) == 1
        p2(mm) = plot(time(inds), sep(inds)-1, 'Color', cols(mm,:));
    else
        p2(mm) = plot(time(inds), sep(inds)-1, '--', 'Color', cols(mm,:));
    end
    xlim([0 25])
    ylim([0 3])
    %ylabel('$(s-D_p)/D_p$')
    xticks(0:10:20)
    yticks(0:3)
    set(gca,'TickLength',[0.02 0.05]);
    xticklabels([])
    yticklabels([])
    xlab = -0.12;
    zlab = 0.94;
    if mm == length(mm)
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 5:10:25;
        ax.YAxis.MinorTickValues = 0.5:1:2.5;
        text(gca,6,0,'*','VerticalAlignment','top');
        text(gca,xlab,zlab,subplot_labels(2),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end

    subplot(2,2,4)
    hold on
    if mod(mm,2) == 1
        %p4(mm) = plot(time(inds), (abs(thet(inds))-thet(1))/(90-thet(1)), 'Color', cols(mm,:));
        p4(mm) = plot(time(inds), abs(thet(inds), 'Color', cols(mm,:));
    else
        %p4(mm) = plot(time(inds), (abs(thet(inds))-thet(1))/(90-thet(1)), '--', 'Color', cols(mm,:));
        p4(mm) = plot(time(inds), abs(thet(inds)), '--', 'Color', cols(mm,:));
    end
    %plot([0 100],[0 0],'Color',[1 1 1]*0.5)
    xlim([0 25])
    %ylim([-0.4 0.2])
    yticklabels([])
    xticks(0:10:20)
    %yticks(-0.4:0.2:0.2)
    set(gca,'TickLength',[0.02 0.05]);
    %ylabel('$u_\mathrm{sep}/w_s$','Interpreter','latex')
    xlab = -0.12;
    zlab = 0.94;
    if mm == length(mm)
        xlabel('$t/\tau$')
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 5:10:25;
        %ax.YAxis.MinorTickValues = -0.3:0.2:0.1;
        text(gca,6,-0.4,'*','VerticalAlignment','top');
        text(gca,xlab,zlab,subplot_labels(4),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end
end

subplot(2,2,2)
shift_axis(-xshift,-zshift)
subplot(2,2,4)
shift_axis(-xshift,+zshift)
leg = legend(p4, labs2);
leg.Location = 'SouthEast';
leg.Box = 'off';
leg.NumColumns = 2;
pos = leg.Position;
pos(1) = 0.5409;
pos(2) = 0.1300;
leg.Position = pos;

figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_sep_angle_gamma_%s_theta_%s',angle_dist,strrep(gamm,'.',''));
print_figure(fname,'format','pdf','size',[7 4])
%cd('..')

