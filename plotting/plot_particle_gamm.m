% compare the particle separation for different stratifications (gamma)

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist = 's2_th90';
cases = {...
    'gamm0.1',...
    ...%'gamm0.3',...
    'gamm0.5',...
    'gamm0.7',...
    'gamm0.9',...
    };

labs = {...
    '$\gamma = 0.1$',...
    ...%'$\gamma = 0.3$',...
    '$\gamma = 0.5$',...
    '$\gamma = 0.7$',...
    '$\gamma = 0.9$',...
    };

style = 'entrain';

switch style
    case 'entrain'
        figure(63)
    case 'settling'
        figure(65)
    case 'sep'
        figure(67)
    case 'drift'
        figure(70)
end
clf

for mm = 1:length(cases)
    cd([base,cases{mm},'/',angle_dist])
    switch style
        case 'entrain'
            plot_entrain(false, true);
        case 'settling'
            plot_settling(1);
        case 'sep'
            p(mm) = plot_particle_separation(0, 1, false, true);
        case 'drift'
            p(mm) = plot_particle_drift(0, 1, false, true);
    end

    % plot the single particle as a dashed line
    cd([base,cases{mm},'/1prt'])
    switch style
        %case 'settling'
        %    plot_settling(0);
        %case 'sep'
            %p(mm) = plot_particle_separation(0, 1, false, true);
        %case 'drift'
            %p(mm) = plot_particle_drift(0, 1, false, true);
    end
end

% add vertical line for when particles reach pycnocline
if ~strcmp(style,'entrain')
    subplot(2,1,1)
    yl = ylim();
    t_pyc_min = min(t_pyc);
    t_pyc_max = max(t_pyc);
    plot([1 1]*t_pyc_min, yl,'k--')
    plot([1 1]*t_pyc_max, yl,'k--')
    subplot(2,1,2)
    yl = ylim();
    plot([1 1]*t_pyc_min, yl,'k--')
    plot([1 1]*t_pyc_max, yl,'k--')
else
    yl = ylim();
    t_pyc_min = min(t_pyc);
    t_pyc_max = max(t_pyc);
    plot([1 1]*t_pyc_min, yl,'k--')
    plot([1 1]*t_pyc_max, yl,'k--')
end

try
    leg = legend(p, labs);
catch
    leg = legend(labs);
end
leg.Location = 'best';
leg.Box = 'off';

figure_defaults()

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_%s_gamma_%s',style,angle_dist);
print_figure(fname,'format','pdf','size',[6 4])
%cd('..')

