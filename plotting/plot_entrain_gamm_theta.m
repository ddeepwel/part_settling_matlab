% compare the entrainment for different stratifications (gamma)
% and particle orientation angle (theta)

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist = 's2_th0_entr';
cases1 = {...
    ...%'gamm1.0',...
    'gamm0.9',...
    'gamm0.7',...
    'gamm0.5',...
    ...%'gamm0.3',...
    'gamm0.1',...
    };
labs1 = {...
    ...%'$\Gamma = 0.0$',...
    '$\Gamma = 0.1$',...
    '$\Gamma = 0.3$',...
    '$\Gamma = 0.5$',...
    ...%'$\Gamma = 0.7$',...
    '$\Gamma = 0.9$',...
    };

gamm = 'gamm0.9';
cases2 = {...
    's2_th0_entr',...
    's2_th22.5_entr',...
    's2_th45_entr',...
    's2_th67.5_entr',...
    's2_th90_entr',...
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
    %if strcmp(cases1{mm},'gamm0.7')
    %    cd([base,cases1{mm},'/',angle_dist,'_cfl0.25'])
    %else
        cd([base,cases1{mm},'/',angle_dist])
    %end
    entr = load('entrained_tracer');
    time = entr.time;
    par = read_params();
    Ri = par.richardson;
    Re = par.Re;
    rho_s = par.rho_s;
    gam = 1 - Ri(1) * Re / 18;
    %vol = entr.volume * 6/pi * (1-gam) * (1-1/rho_s);
    vol = entr.volume * 6/pi;
    % check if reached bottom and don't plot after this
    %hit_bottom = reached_bottom(4);
    %if hit_bottom
    %    [~, ti] = reach_bottom_time(4);
    %    inds = 1:ti;
    %else
    %    inds = 1:length(time);
    %end
    %if strcmp(cases1{mm}, 'gamm1.0')
    %    p(mm) = plot(time, vol, 'Color', [0 0 0]);
    %else
        p(mm) = plot(time, vol, 'Color', cols(mm,:));
    %end

    % plot the settling of just a single particle in a dashed line
    %cd([base,cases1{mm},'/1prt'])
    %[time, y_p, v_p] = settling(0);
    %% check if reached bottom and don't plot after this
    %hit_bottom = reached_bottom(4);
    %if hit_bottom
    %    [~, ti] = reach_bottom_time(4);
    %    inds = 1:ti;
    %else
    %    inds = 1:length(time);
    %end
    %plot(time(inds), v_p(inds),'--', 'Color', cols(mm,:))
end

xlim([0 40])
ylim([0 30])
xlabel('$t/\tau$')
%ylabel('$M_\mathrm{entrain}/M_p$','Interpreter','Latex')
ylabel('$$','Interpreter','Latex')

leg = legend(p, labs1);
leg.Location = 'NorthEast';
leg.Box = 'off';
%set(gca,'XMinorTick','on','YMinorTick','on')
xlab = -0.25;
zlab = 0.94;
text(gca,xlab,zlab,subplot_labels(1),...
            'Color','k','Units','normalized','Interpreter','Latex')

subplot(1,2,2)
hold on
% plot the settling of the center of mass of the particles 
%cd([base,gamm,'/1prt'])
%[time, y_p, v_p] = settling(0);
%p0 = plot(time, v_p,'k-');

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
end

xlim([0 40])
ylim([0 30])
yticklabels([])
xlabel('$t/\tau$')
%ylabel('$w_p/w_s$')

leg = legend(p(end:-1:1), {labs2{end:-1:1}});
leg.Location = 'NorthEast';
leg.Box = 'off';
xlab = -0.15;
text(gca,xlab,zlab,subplot_labels(2),...
            'Color','k','Units','normalized','Interpreter','Latex')

figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_entrain_gamma_%s_theta_%s',angle_dist,strrep(gamm,'.',''));
print_figure(fname,'format','pdf','size',[7 3])
%cd('..')

