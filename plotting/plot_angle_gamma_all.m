% compare the particle settling for different stratifications (gamma) for two orientation angles (in subplot a and b)
% and then varying the particle orientation angle (theta) in subplot c

clear('p')

figure(161)
clf

cols = default_line_colours();

base = '/Volumes/2part_settling/2particles/sigma1/Re1_4/';
angle_dist = {'s2_th22.5','s2_th45','s2_th67.5'};
cases = {...
    'gamm1.0',...
    'gamm0.9',...
    'gamm0.7',...
    'gamm0.5',...
    'gamm0.3',...
    %'gamm0.1',...
    };
gams = [1 0.9 0.7 0.5 0.3 0.1];
labs = {...
    '$\Gamma = 0.0$',...
    '$\Gamma = 0.1$',...
    '$\Gamma = 0.3$',...
    '$\Gamma = 0.5$',...
    '$\Gamma = 0.7$',...
    %'$\Gamma = 0.9$',...
    };
for nn = 1:3
    ax = subplot(1,3,nn);
    hold on
switch angle_dist{nn}
    case 's2_th22.5'
        suffix = {... % th22.5
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            %'',... % ???
            };
        ang = 22.5;
        xlab = -0.21;
    case 's2_th45'
        suffix = {... % th45
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',... % diagnos shows _dx25 is pretty bad, but it lookds good here
            %'_dx25',...
            };
        ang = 45;
        xlab = -0.12;
    case 's2_th67.5'
        suffix = {... % th22.5
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            %'_dx25',...
            };
        ang = 67.5;
        xlab = -0.12;
end

direc = [base,cases{1},'/',angle_dist{nn},suffix{1}];
cd(direc)
par = read_params();
g = 9.81;
rho_s = par.rho_s;
D_p = 80e-6;
nu = 1e-6;
%V_p = 4/3*pi * (D_p/2)^3;
%Fg = (rho_s - 1) * V_p * g;
%u_h = Fg / 8/pi/nu * sind(ang) * sind(ang);
%w_s = 1/18 * (rho_s - 1) * g * D_p^2 / nu;
w2_w1 = gams./(rho_s-gams*(rho_s-1));
mfactor = kynch_factor(1/2); % input argument = 1/s
uh_w2 = mfactor * sind(90-ang) * sind(90-ang);


for mm = 1:length(cases)
    direc = [base,cases{mm},'/',angle_dist{nn},suffix{mm}];
    disp(direc)
    cd(direc)
    [time, th] = particle_angle();
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end

    hold on
    if strcmp(cases{mm}, 'gamm1.0')
        p1(mm) = plot(time(inds), abs(th(inds)), 'k');
    else
        p1(mm) = plot(time(inds), abs(th(inds)), 'Color', cols(mm-1,:));
    end
    xlim([0 80])
    ylim([0 90])
    yticks([0 22.5 45 67.5 90])
    set(gca,'TickLength',[0.02 0.05]);
    if mm == length(mm)
        xlabel('$t/\tau$')
        set(ax,'XMinorTick','on','YMinorTick','on')
        ax.XAxis.MinorTickValues = 10:20:70;
        ax.YAxis.MinorTickValues = 11.25:22.5:90;
        text(gca,6,0,'*','VerticalAlignment','top');
        shift_axis(-0.03*(nn-2),0.04)
        text(gca,xlab,0.9,subplot_labels(nn),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end
    if nn == 1
        ylabel('$\theta$ (deg)')
    else
        yticklabels([])
    end
end
end

leg = legend(p1(end:-1:1), {labs{end:-1:1}});
leg.Location = 'SouthEast';
leg.Box = 'off';
%leg.NumColumns = 2;
%ax = gca;
%pos = ax.Position;
%pos(3) = xlen;
%pos(4) = zlen;
%pos(1) = 0.5- xlen/2;
%ax.Position = pos;
%shift_axis(0,+zshift)

figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_angle_all');
print_figure(fname,'format','pdf','size',[10 3])
%cd('..')

