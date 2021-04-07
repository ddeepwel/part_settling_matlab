% compare the entrainment for different Reynolds number

base = '/Volumes/2part_settling/2particles/sigma1/';
angle_dist = 'gamm0.9/s2_th90';
cases = {...
    ...%'Re1',...
    'Re1_4',...
    'Re1_8',...
    'Re1_16',...
    };
suffix = {...
    ...%'',...
    '_Re_case',...
    '_Pe175',...
    '_Pe175',...
    };
labs = {...
    ...%'$Re=1$',...
    '$Re=1/4$',...
    '$Re=1/8$',...
    '$Re=1/16$',...
    };

figure(59)
clf

subplot(1,2,1)
hold on

for mm = 1:length(cases)
    cd([base,cases{mm},'/',angle_dist,suffix{mm}])
    load('entrained_tracer.mat')
    plot(time,volume * 6/pi);
end

xlabel('$t/\tau$')
ylabel('$C_\mathrm{entrain}/V_p$','Interpreter','Latex')

xlim([0 40])
ylim([0 30])
set(gca,'XMinorTick','on','YMinorTick','on')
yticks(0:10:30)
ax = gca;
ax.XAxis.MinorTickValues = 5:5:40;
ax.YAxis.MinorTickValues = 5:10:25;
set(gca,'TickLength',[0.02 0.05]);
shift_axis(0,0.045)
keyboard

leg = legend(labs);
leg.Location = 'NorthEast';
leg.Box = 'off';
%xlab = -0.2;
%zlab = 0.94;
text(gca,6,0,'*','VerticalAlignment','top');
text(gca,-0.21,0.9,subplot_labels(1),...
    'Color','k','Units','normalized','Interpreter','Latex')


%%%%% subplot 2 %%%%%
subplot(1,2,2)
hold on

t_i = 25;

base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/';
cases_Re = {'Re1_4','Re1_8','Re1_16'};
spec = {'s2_th90_Re_case','s2_th90_Pe175','s2_th90_Pe175'};

for mm = 1:length(cases_Re)
    direc = [base,cases_Re{mm},'/gamm0.9/',spec{mm}];
    disp(direc)
    cd(direc)

    % find where particle is at t_i
    particle_data = check_read_dat('mobile_1');
    t1 = particle_data.time;
    x1 = particle_data.x;
    y1 = particle_data.y;
    z1 = particle_data.z;
    t1_ind = nearest_index(t1, t_i);
    xp = x1(t1_ind);
    yp = y1(t1_ind);
    zp = z1(t1_ind);

    % get settling velocity
    Dmat = FiniteDiff(t1, 1, 2, true, false); % some cases have variable time step 
    v1 = Dmat * y1;
    v_settling = v1(t1_ind);

    % get velocity field
    t2d = get_output_times('Data2d');
    t2d_ind = nearest_index(t2d,t_i) -1;
    [v2d, vf, x2d, y2d, xy_p] = plot_stat2d('xy', 'v', t2d_ind,50+mm);
    % check to see if particles match
    if [xp yp] ~= xy_p
        error('particle positions do not match')
    end

    % find horizontal slice
    y_ind = nearest_index(y2d,yp);
    v1d = squeeze(v2d(:,y_ind));
    xLind = nearest_index(x2d,xp+0.5)-1;

    par = read_params();
    dx = (par.xmax - par.xmin)/par.NXM;

    figure(59)
    subplot(1,2,2)
    plot(x2d(xLind:end) -(xp+0.5) +dx, v1d(xLind:end) - v_settling)

    if mm == 3
        xlim([0 3])
        xlabel('$r/D_p - 1/2$')
        ylabel('$(w - w_p)/w_s$','Interpreter','Latex')
        ax = gca;
        set(ax,'XMinorTick','on','YMinorTick','on')
        ax.XAxis.MinorTickValues = 0.5:1:3;
        %ax.YAxis.MinorTickValues = 0.2:0.4:1;
        text(gca,-0.23,0.9,subplot_labels(2),...
            'Color','k','Units','normalized','Interpreter','Latex')
        shift_axis(0,0.045)
    end
end

figure_defaults()

cd('../../../figures')
%print_figure('entrain_Re_BL','format','pdf','size',[7 3])
