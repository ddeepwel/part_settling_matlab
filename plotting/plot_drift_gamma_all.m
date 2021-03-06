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
            '_dx25',... % diagnos shows _dx25 is pretty bad
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
uh_w2 = mfactor * sind(90-ang) * cosd(90-ang);

for mm = 1:length(cases)
    % go to directory
    direc = [base,cases{mm},'/',angle_dist{nn},suffix{mm}];
    disp(direc)
    cd(direc)
    % load data
    [time, ~, u_drift] = particle_drift();
    % check if reached bottom and don't plot after this
    hit_bottom = reached_bottom();
    if hit_bottom
        [~, ti] = reach_bottom_time();
        inds = 1:ti;
    else
        inds = 1:length(time);
    end

    % plot data
    hold on
    if strcmp(cases{mm}, 'gamm1.0')
        % homogeneous fluid
        %p2(mm) = plot(time(inds), u_drift(inds) / w2_w1(mm) / uh_w2, 'k'); % scaled by lower layer settling speed
        p2(mm) = plot(time(inds), u_drift(inds)             / uh_w2, 'k');  % scaled by upper layer settling speed
        % predicted drift
        %plot([16 20], [1 1]*w2_w1(mm),'k','linewidth',2)
    else
        % stratified fluid
        %p2(mm) = plot(time(inds), u_drift(inds) / w2_w1(mm) / uh_w2, 'Color', cols(mm-1,:)); % scaled by lower layer settling speed
        p2(mm) = plot(time(inds), u_drift(inds)             / uh_w2, 'Color', cols(mm-1,:));  % scaled by upper layer settling speed
        % predicted drift
        %if mm == 5
        %    plot([70 74], [1 1]*w2_w1(mm),'Color',cols(mm-1,:),'linewidth',2)
        %else
        %    plot(time(inds(end))+ [-4 0], [1 1]*w2_w1(mm),'Color',cols(mm-1,:),'linewidth',2)
        %end
    end

    % plot the observed drift from multiple simulations
    if mm ~= 1
        cd([pwd,'_homo'])
    else
        tind = nearest_index(time, 2);
        u_drift_upper = u_drift(tind); % upper layer drift speed at Re=1/4
        u_drift_upper = uh_w2; % this is actually the drift per settling rate in any layer
    end
    [time_homo, ~, u_drift_homo] = particle_drift();
    tind = nearest_index(time_homo, 2);
    u_drift_lower = u_drift_homo(tind);
    if strcmp(cases{mm}, 'gamm1.0')
        plot([16 22], [1 1]*u_drift_lower/u_drift_upper(mm),'k:','linewidth',2)
    else
        if mm == 5
            plot([70 76], [1 1]*u_drift_lower/u_drift_upper,':','Color',cols(mm-1,:),'linewidth',2)
        else
            plot(time(inds(end))+ [-4 2], [1 1]*u_drift_lower/u_drift_upper,':','Color',cols(mm-1,:),'linewidth',2)
        end
    end



    % make pretty
    xlim([0 80])
    ylim([0 1.25])
    yticks(0:0.5:2)
    set(gca,'TickLength',[0.02 0.05]);
    if mm == length(mm)
        xlabel('$t/\tau$')
        set(ax,'XMinorTick','on','YMinorTick','on')
        ax.XAxis.MinorTickValues = 10:20:70;
        ax.YAxis.MinorTickValues = 0:0.25:2;
        text(gca,6,0,'*','VerticalAlignment','top');
        shift_axis(-0.03*(nn-2),0.04)
        text(gca,xlab,0.9,subplot_labels(nn),...
            'Color','k','Units','normalized','Interpreter','Latex')
    end
    if nn == 1
        ylabel('$u_\textrm{drift}/u_h$','Interpreter','latex')
    else
        yticklabels([])
    end
end
end

leg = legend(p2, labs);
leg.Location = 'NorthEast';
leg.Box = 'off';

figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_drift_all');
%print_figure(fname,'format','pdf','size',[10 3])
%cd('..')

