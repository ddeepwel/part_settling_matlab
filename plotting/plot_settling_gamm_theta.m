% compare the particle settling for different stratifications (gamma)
% and particle orientation angle (theta)

clear all
base = '/Volumes/2part_settling/2particles/sigma1/Re1_4/';

% stratifications for 1st subplot
angle_dist = 's2_th0';
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
gm = [1.0 0.9 0.7 0.5 0.3 0.1]; 
suffix = {...
    '_dx25',...
    '_dx30',...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    %'_entr',... % the _resdbl case also has problems (the particles reverses settling due to numerical issue)
    };
suffix_1prt = {...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    %'',...
    };

% angles for 2nd subplot
gamm = 'gamm0.9';
cases2 = {...
    's2_th0_dx30',...
    's2_th22.5_dx25',...
    's2_th45_dx25',...
    's2_th67.5_dx25',...
    's2_th90_dx25',...
    };
labs2 = {...
    '$\theta = 0^\circ$',...
    '$\theta = 22.5^\circ$',...
    '$\theta = 45^\circ$',...
    '$\theta = 67.5^\circ$',...
    '$\theta = 90^\circ$',...
    };

% setup figure
figure(165)
clf
cols = default_line_colours();
cols = [0 0 0; cols];
subplot(1,2,1)
hold on

% 1st subplot
for mm = 1:length(cases1)
    cd([base,cases1{mm},'/',angle_dist,suffix{mm}])
    [t_p0, y_p0, v_p0] = settling(0);
    [t_p1, y_p1, v_p1] = settling(1);
    vp_com = (v_p0 + v_p1)/2;
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(t_p0);
    end
    p1(mm) = plot(t_p0(inds), -vp_com(inds), 'Color', cols(mm,:));

    % plot the settling of just a single particle in a dashed line
    cd([base,cases1{mm},'/1prt',suffix_1prt{mm}])
    [time, y_p, v_p] = settling(0);
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end
    plot(time(inds), -v_p(inds),'--', 'Color', cols(mm,:))

    % plot the stokes settling speed in the lower layer
    %par = read_params();
    %rho_s = par.rho_s;
    %rho_2 = rho_s - gm(mm) * (rho_s - 1);
    %ws2_ws1 = (rho_s/rho_2 - 1) / (rho_s - 1);
    %if time(inds(end))+4 > 80
    %    plot([70 75], [1 1]*ws2_ws1,'-','Color',cols(mm,:),'LineWidth',2);
    %else
    %    plot([time(inds(end))-5 time(inds(end))], [1 1]*ws2_ws1,'-','Color',cols(mm,:),'LineWidth',2);
    %end
    
    % plot the observed settling speed in the lower layer
    if mm ~= 1
        cd('../1prt_dx25_homo')
    else
        tind = nearest_index(time, 1);
        u_settle_lower = vp_com(tind);
    end
    [time_homo, y_p0_homo, v_p_homo] = settling(0);
    %[time_homo, y_p1_homo, v_p1_homo] = settling(1);
    %v_p_homo = (v_p0_homo + v_p1_homo)/2;
    tind = nearest_index(time_homo, 5);
    v_settle_lower = v_p_homo(tind);
    if time(inds(end))+4 > 80
        plot([70 75], [1 1]*(-v_settle_lower),':','Color',cols(mm,:),'LineWidth',2);
    else
        plot([time(inds(end))-5 time(inds(end))], [1 1]*(-v_settle_lower),':','Color',cols(mm,:),'LineWidth',2);
    end

    % add the recovery time
    if mm > 1
        trec = [16 24 38 71];
        plot([1 1]*(6+trec(mm-1)), [0.02 0.06],'Color',cols(mm,:),'LineWidth',2)
    end
end

xlim([0 80])
ylim([0 1.2])
xlabel('$t/\tau$')
ylabel('$w_c/w_s$')

leg = legend(p1, labs1);
leg.Location = 'NorthEast';
%pos = leg.Position;
%pos(2) = pos(2) + 0.0005;
%leg.Position = pos;
leg.Box = 'off';
yticks(0:0.4:1.2)
set(gca,'XMinorTick','on','YMinorTick','on')
ax = gca;
ax.XAxis.MinorTickValues = 10:20:70;
ax.YAxis.MinorTickValues = 0.2:0.4:1.4;
set(gca,'TickLength',[0.02 0.05]);
text(gca,6,0,'*','VerticalAlignment','top');
xlab = -0.15;
zlab = 0.9;
text(gca,xlab,zlab,subplot_labels(1),...
            'Color','k','Units','normalized','Interpreter','Latex')


% 2nd subplot
cols = default_line_colours();
subplot(1,2,2)
hold on
% plot the settling of the center of mass of the particles 
cd([base,gamm,'/1prt_dx25'])
[time, y_p, v_p] = settling(0);
p0 = plot(time, -v_p,'k-');

for mm = 1:length(cases2)
    cd([base,gamm,'/',cases2{mm}])
    [t_p0, y_p0, v_p0] = settling(0);
    [t_p1, y_p1, v_p1] = settling(1);
    if mod(mm,2) == 1
        p2(mm) = plot(t_p0, -(v_p0+v_p1)/2, 'Color', cols(mm,:));
    else
        p2(mm) = plot(t_p0, -(v_p0+v_p1)/2, '--', 'Color', cols(mm,:));
    end
end

xlim([0 25])
ylim([0 1.2])
yticklabels([])
xlabel('$t/\tau$')
%ylabel('$w_p/w_s$')
set(gca,'XMinorTick','on','YMinorTick','off')
ax = gca;
ax.XAxis.MinorTickValues = 5:10:25;
set(gca,'TickLength',[0.02 0.05]);
text(gca,6,0,'*','VerticalAlignment','top');

leg = legend([p2 p0], [labs2, '1 particle']);
leg.Location = 'SouthEast';
leg.Box = 'off';
xlab = -0.1;
text(gca,xlab,zlab,subplot_labels(2),...
            'Color','k','Units','normalized','Interpreter','Latex')

figure_defaults

subplot(1,2,1)
%pos = get(gca,'position');
%pos(4) = pos(4) * 0.9;
%set(gca,'position',pos);
shift_axis(0.02,0.03)
subplot(1,2,2)
%pos = get(gca,'position');
%pos(4) = pos(4) * 0.9;
%set(gca,'position',pos);
shift_axis(-0.02,0.03)

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_settling_gamma_%s_theta_%s',angle_dist,strrep(gamm,'.',''));
% change font size to 14
%print_figure(fname,'format','jpeg','size',[10 3]*4/3,'res',600)
%cd('..')

