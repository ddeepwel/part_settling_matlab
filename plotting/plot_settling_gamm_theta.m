% compare the particle settling for different stratifications (gamma)
% and particle orientation angle (theta)

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist = 's2_th0';
cases1 = {...
    'gamm0.9',...
    'gamm0.7',...
    'gamm0.5',...
    ...%'gamm0.3',...
    'gamm0.1',...
    };
labs1 = {...
    '$\gamma = 0.9$',...
    '$\gamma = 0.7$',...
    '$\gamma = 0.5$',...
    ...%'$\gamma = 0.3$',...
    '$\gamma = 0.1$',...
    };

gamm = 'gamm0.9';
cases2 = {...
    's2_th0',...
    's2_th22.5',...
    's2_th45',...
    's2_th67.5',...
    's2_th90',...
    };
labs2 = {...
    '$\theta = 0^\circ$',...
    '$\theta = 22.5^\circ$',...
    '$\theta = 45^\circ$',...
    '$\theta = 67.5^\circ$',...
    '$\theta = 90^\circ$',...
    };

figure(165)
clf

cols = default_line_colours();

subplot(1,2,1)
hold on
for mm = 1:length(cases1)
    if strcmp(cases1{mm},'gamm0.7')
        cd([base,cases1{mm},'/',angle_dist,'_cfl0.25'])
    else
        cd([base,cases1{mm},'/',angle_dist])
    end
    [t_p0, y_p0, v_p0] = settling(0);
    [t_p1, y_p1, v_p1] = settling(1);
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom(4);
    if hit_bottom
        [~, ti] = reach_bottom_time(4);
        inds = 1:ti;
    else
        inds = 1:length(t_p0);
    end
    p(mm) = plot(t_p0(inds), (v_p0(inds)+v_p1(inds))/2, 'Color', cols(mm,:));

    % plot the settling of just a single particle in a dashed line
    cd([base,cases1{mm},'/1prt'])
    [time, y_p, v_p] = settling(0);
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom(4);
    if hit_bottom
        [~, ti] = reach_bottom_time(4);
        inds = 1:ti;
    else
        inds = 1:length(time);
    end
    plot(time(inds), v_p(inds),'--', 'Color', cols(mm,:))
end

xlim([0 60])
ylim([-1.2 0])
xlabel('$t/\tau$')
ylabel('$w_c/w_s$')

leg = legend(p(end:-1:1), {labs1{end:-1:1}});
leg.Location = 'SouthEast';
leg.Box = 'off';
%set(gca,'XMinorTick','on','YMinorTick','on')
xlab = -0.25;
zlab = 0.94;
text(gca,xlab,zlab,subplot_labels(1),...
            'Color','k','Units','normalized','Interpreter','Latex')

subplot(1,2,2)
hold on
% plot the settling of the center of mass of the particles 
cd([base,gamm,'/1prt'])
[time, y_p, v_p] = settling(0);
p0 = plot(time, v_p,'k-');

for mm = 1:length(cases2)
    cd([base,gamm,'/',cases2{mm}])
    [t_p0, y_p0, v_p0] = settling(0);
    [t_p1, y_p1, v_p1] = settling(1);
    p(mm) = plot(t_p0, (v_p0+v_p1)/2, 'Color', cols(mm,:));
end

xlim([0 25])
ylim([-1.2 0])
yticklabels([])
xlabel('$t/\tau$')
%ylabel('$w_p/w_s$')

leg = legend([p0, p(end:-1:1)], ['1 particle',{labs2{end:-1:1}}]);
leg.Location = 'NorthEast';
leg.Box = 'off';
xlab = -0.15;
text(gca,xlab,zlab,subplot_labels(2),...
            'Color','k','Units','normalized','Interpreter','Latex')

figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_settling_gamma_%s_theta_%s',angle_dist,strrep(gamm,'.',''));
print_figure(fname,'format','pdf','size',[7 3])
%cd('..')

