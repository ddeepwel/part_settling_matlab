% compare the entrainment for different stratifications (gamma)
% and particle orientation angle (theta)

clear('p')

base = '/Volumes/2part_settling/2particles/sigma1/Re1_4/';
angle_dist = 's2_th0';
cases1 = {...
    ...%'gamm1.0',...
    'gamm0.9',...
    'gamm0.7',...
    'gamm0.5',...
    'gamm0.3',...
    %'gamm0.1',...
    };
labs1 = {...
    ...%'$\Gamma = 0.0$',...
    '$\Gamma = 0.1$',...
    '$\Gamma = 0.3$',...
    '$\Gamma = 0.5$',...
    '$\Gamma = 0.7$',...
    %'$\Gamma = 0.9$',...
    };
suffix = {...
    '_dx30',...
    '_dx25',...
    '_dx25',...
    '_dx25',...
    %'_dx25',...
    };

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

figure(165)
clf

cols = default_line_colours();

subplot(1,2,1)
hold on
for mm = 1:length(cases1)
    cd([base,cases1{mm},'/',angle_dist,suffix{mm}])
    entr = load('entrained_tracer');
    time = entr.time;
    par = read_params();
    Ri = par.richardson;
    Re = par.Re;
    rho_s = par.rho_s;
    gam = 1 - Ri(1) * Re / 18;
    %vol = entr.volume * 6/pi * (1-gam) * (1-1/rho_s);
    vol = entr.volume * 6/pi;
    %vol = entr.volume * (80e-6)^3;
    % check if reached bottom and don't plot after this
    %hit_bottom = reached_bottom();
    %if hit_bottom
    %    [~, ti] = reach_bottom_time();
    %    inds = 1:ti;
    %else
    %    inds = 1:length(time);
    %end
    %if strcmp(cases1{mm}, 'gamm1.0')
    %    p(mm) = plot(time, vol, 'Color', [0 0 0]);
    %else
        p(mm) = plot(time, vol, 'Color', cols(mm,:));
    %end
    

    % plot time when trailing particle is 15 D_p below interface
    [t,yp] = settling(0);
    yi = par.pyc_location;
    ind15 = nearest_index(yp,yi-15);
    tind = nearest_index(time,t(ind15));
    plot(time(tind),vol(tind),'o','Color',cols(mm,:),'MarkerFaceColor',cols(mm,:),'MarkerSize',3)
end

xlim([0 150])
ylim([0 30])
xlabel('$t/\tau$')
%ylabel('$M_\mathrm{entrain}/M_p$','Interpreter','Latex')
ylabel('$C_\mathrm{entrain}/V_p$','Interpreter','Latex')
%ylabel('$C_\mathrm{entrain}$','Interpreter','Latex')
set(gca,'XMinorTick','on','YMinorTick','on')
yticks(0:10:30)
ax = gca;
ax.XAxis.MinorTickValues = 25:50:125;
ax.YAxis.MinorTickValues = 5:10:25;
set(gca,'TickLength',[0.02 0.05]);

leg = legend(p, labs1);
leg.Location = 'NorthEast';
leg.Box = 'off';
xlab = -0.2;
zlab = 0.94;
text(gca,6,0,'*','VerticalAlignment','top');
text(gca,xlab,zlab,subplot_labels(1),...
            'Color','k','Units','normalized','Interpreter','Latex')

subplot(1,2,2)
hold on

for mm = 1:length(cases2)
    cd([base,gamm,'/',cases2{mm}])
    entr = load('entrained_tracer');
    time = entr.time;
    par = read_params();
    Ri = par.richardson;
    Re = par.Re;
    rho_s = par.rho_s;
    gam = 1 - Ri(1) * Re / 18;
    %vol = entr.volume * 6/pi * (1-gam) * (1-1/rho_s);
    vol = entr.volume * 6/pi;
    p(mm) = plot(time, vol, 'Color', cols(mm,:));

    % plot time when trailing particle is 15 D_p below interface
    [t,yp] = settling(0);
    yi = par.pyc_location;
    ind15 = nearest_index(yp,yi-15);
    tind = nearest_index(time,t(ind15));
    plot(time(tind),vol(tind),'o','Color',cols(mm,:),'MarkerFaceColor',cols(mm,:),'MarkerSize',3)
end

xlim([0 30])
ylim([0 30])
yticklabels([])
yticks(0:10:30)
xlabel('$t/\tau$')
%ylabel('$w_p/w_s$')
set(gca,'XMinorTick','on','YMinorTick','on')
ax = gca;
ax.XAxis.MinorTickValues = 5:5:40;
ax.YAxis.MinorTickValues = 5:10:25;
set(gca,'TickLength',[0.02 0.05]);

leg = legend(p(end:-1:1), {labs2{end:-1:1}});
leg.Location = 'NorthEast';
leg.Box = 'off';
xlab = -0.15;
text(gca,6,0,'*','VerticalAlignment','top');
text(gca,xlab,zlab,subplot_labels(2),...
            'Color','k','Units','normalized','Interpreter','Latex')

figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_entrain_gamma_%s_theta_%s',angle_dist,strrep(gamm,'.',''));
print_figure(fname,'format','pdf','size',[7 3])
cd('..')

