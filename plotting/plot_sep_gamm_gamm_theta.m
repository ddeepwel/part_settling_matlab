% compare the particle separation for different stratifications (gamma) for two orientation angles (in subplot a and b)
% and then varying the particle orientation angle (theta) in subplot c

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist1 = 's2_th0';
cases1 = {...
    'gamm1.0',...
    'gamm0.9',...
    'gamm0.7',...
    'gamm0.5',...
    'gamm0.3',...
    %'gamm0.1',...
    };
labs1 = {...
    '$\Gamma = 0.0$',...
    '$\Gamma = 0.1$',...
    '$\Gamma = 0.3$',...
    '$\Gamma = 0.5$',...
    '$\Gamma = 0.7$',...
    %'$\Gamma = 0.9$',...
    };
suffix1 = {...
    '_dx25',...
    '_dx30',...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    %'_resdbl',... % the _resdbl case has problems (the particles reverses settling due to numerical issue, but we're going with it here)
    };

angle_dist2 = 's2_th90';
suffix2 = {...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    %'',... 
    };

gamm = 'gamm0.9';
cases3 = {...
    's2_th0_dx30',...
    's2_th22.5_dx25',...
    's2_th45_dx25',...
    's2_th67.5_dx25',...
    's2_th90_dx25',...
    };
labs3 = {...
    '$\theta = 0^\circ$',...
    '$\theta = 22.5^\circ$',...
    '$\theta = 45^\circ$',...
    '$\theta = 67.5^\circ$',...
    '$\theta = 90^\circ$',...
    };

figure(165)
clf

cols = default_line_colours();

for mm = 1:length(cases1)
    cd([base,cases1{mm},'/',angle_dist1,suffix1{mm}])
    [time, sep, sep_vel] = particle_separation();
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end

    subplot(1,3,1)
    hold on
    if strcmp(cases1{mm}, 'gamm1.0')
        p1(mm) = plot(time(inds), sep(inds)-1, 'k');
    else
        p1(mm) = plot(time(inds), sep(inds)-1, 'Color', cols(mm-1,:));
    end
    xlim([0 80])
    ylim([0 3])
    yticks(0:3)
    %yticklabels([0 {''} 2 {''} 4])
    set(gca,'TickLength',[0.02 0.05]);
    xlab = -0.20;
    zlab = 0.94;
    if mm == length(mm)
        xlabel('$t/\tau$')
        ylabel('$s/D_p$')
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 10:20:50;
        ax.YAxis.MinorTickValues = 0.5:1:2.5;
        text(gca,6,0,'*','VerticalAlignment','top');
        text(gca,xlab,zlab,subplot_labels(1),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end
end
%xshift = 0.03;
zshift = 0.025;
xlen = 0.25;
zlen = 0.80;
xdx  = 0.04;
ax = gca;
pos = ax.Position;
pos(3) = xlen;
pos(4) = zlen;
pos(1) = 0.5 - xlen/2 - xdx - xlen;
ax.Position = pos;
shift_axis(0,+zshift)

for mm = 1:length(cases1)
    cd([base,cases1{mm},'/',angle_dist2,suffix2{mm}])
    [time, sep, sep_vel] = particle_separation();
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end

    subplot(1,3,2)
    hold on
    if strcmp(cases1{mm}, 'gamm1.0')
        p2(mm) = plot(time(inds), sep(inds)-1, 'k');
    else
        p2(mm) = plot(time(inds), sep(inds)-1, 'Color', cols(mm-1,:));
    end
    xlim([0 80])
    ylim([0 3])
    yticklabels([])
    %yticks(0:4)
    %yticklabels([0 {''} 2 {''} 4])
    set(gca,'TickLength',[0.02 0.05]);
    xlab = -0.12;
    zlab = 0.94;
    if mm == length(mm)
        xlabel('$t/\tau$')
        %ylabel('$s/D_p$')
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 10:20:50;
        ax.YAxis.MinorTickValues = 0.5:1:2.5;
        text(gca,6,0,'*','VerticalAlignment','top');
        text(gca,xlab,zlab,subplot_labels(2),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end
end

leg = legend(p2, labs1);
leg.Location = 'NorthWest';
leg.Box = 'off';
%leg.NumColumns = 2;
ax = gca;
pos = ax.Position;
pos(3) = xlen;
pos(4) = zlen;
pos(1) = 0.5- xlen/2;
ax.Position = pos;
shift_axis(0,+zshift)

for mm = 1:length(cases3)
    cd([base,gamm,'/',cases3{mm}])
    [time, sep, sep_vel] = particle_separation();
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end

    subplot(1,3,3)
    hold on
    if mod(mm,2) == 1
        p3(mm) = plot(time(inds), sep(inds)-1, 'Color', cols(mm,:));
    else
        p3(mm) = plot(time(inds), sep(inds)-1, '--', 'Color', cols(mm,:));
    end
    xlim([0 25])
    ylim([0 3])
    %ylabel('$(s-D_p)/D_p$')
    xticks(0:10:20)
    yticks(0:3)
    set(gca,'TickLength',[0.02 0.05]);
    %xticklabels([])
    yticklabels([])
    xlab = -0.12;
    zlab = 0.94;
    if mm == length(mm)
        xlabel('$t/\tau$')
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 5:10:25;
        ax.YAxis.MinorTickValues = 0.5:1:2.5;
        text(gca,6,0,'*','VerticalAlignment','top');
        text(gca,xlab,zlab,subplot_labels(3),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end
end

ax = gca;
pos = ax.Position;
pos(3) = xlen;
pos(4) = zlen;
pos(1) = 0.5 + xlen/2 + xdx;
ax.Position = pos;
shift_axis(0,+zshift)
leg = legend(p3, labs3);
leg.Location = 'NorthWest';
leg.Box = 'off';
%leg.NumColumns = 2;
%pos = leg.Position;
%pos(1) = 0.5409;
%pos(2) = 0.1300;
%leg.Position = pos;

figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_sep_%s_%s_theta_%s',angle_dist1, angle_dist2,strrep(gamm,'.',''));
print_figure(fname,'format','pdf','size',[8 3.5])
%cd('..')

