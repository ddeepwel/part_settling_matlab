% compare the particle settling for different stratifications (gamma) for two orientation angles (in subplot a and b)
% and then varying the particle orientation angle (theta) in subplot c

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist = 's2_th45';
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
switch angle_dist
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
    case 's2_th45'
        suffix = {... % th45
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',... % diagnos shows _dx25 is pretty bad
            %'_dx25',...
            };
        ang = 45;
    case 's2_th67.5'
        suffix = {... % th22.5
            ...%'',... has not been run
            '_dx25',...
            '_dx25',...
            '_dx25',...
            '_dx25',...
            %'',...
            };
        ang = 67.5;
end

direc = [base,cases{1},'/',angle_dist,suffix{1}];
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
uh_w2 = mfactor * sind(90-ang) * cosd(90-ang);

figure(161)
clf

cols = default_line_colours();

for mm = 1:length(cases)
    direc = [base,cases{mm},'/',angle_dist,suffix{mm}];
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

    [time, ~, u_drift] = particle_drift();
    hold on
    if strcmp(cases{mm}, 'gamm1.0')
        %p2(mm) = plot(time(inds), u_drift(inds) / w2_w1(mm) / uh_w2, 'k'); % scaled by lower layer settling speed
        p2(mm) = plot(time(inds), u_drift(inds)             / uh_w2, 'k');  % scaled by upper layer settling speed
        plot([16 20], [1 1]*w2_w1(mm),'k','linewidth',2)
    else
        %p2(mm) = plot(time(inds), u_drift(inds) / w2_w1(mm) / uh_w2, 'Color', cols(mm-1,:)); % scaled by lower layer settling speed
        p2(mm) = plot(time(inds), u_drift(inds)             / uh_w2, 'Color', cols(mm-1,:));  % scaled by upper layer settling speed
        if mm == 5
            plot([70 74], [1 1]*w2_w1(mm),'Color',cols(mm-1,:),'linewidth',2)
        else
            plot(time(inds(end))+ [-4 0], [1 1]*w2_w1(mm),'Color',cols(mm-1,:),'linewidth',2)
        end
    end
    xlim([0 80])
    ylim([0 1.25])
    yticks(0:2)
    %yticklabels([0 {''} 2 {''} 4])
    set(gca,'TickLength',[0.02 0.05]);
    if mm == length(mm)
        xlabel('$t/\tau$')
        ylabel('$u_\textrm{drift}/u_h$','Interpreter','latex')
        set(gca,'XMinorTick','on','YMinorTick','on')
        ax = gca;
        ax.XAxis.MinorTickValues = 10:20:70;
        ax.YAxis.MinorTickValues = 0:0.25:2;
        text(gca,6,0,'*','VerticalAlignment','top');
    end
end

leg = legend(p2, labs);
leg.Location = 'NorthEast';
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
fname = sprintf('part_drift_%s',strrep(angle_dist,'.',''));
print_figure(fname,'format','pdf','size',[4 3])
%cd('..')

