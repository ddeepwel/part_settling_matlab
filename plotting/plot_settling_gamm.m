% compare the particle settling for different stratifications (gamma)

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist = 's2_th0';
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

figure(165)
clf
hold on

cols = default_line_colours();

for mm = 1:length(cases)
    cd([base,cases{mm},'/',angle_dist])
    [t_p0, y_p0, v_p0] = settling(0);
    [t_p1, y_p1, v_p1] = settling(1);
    p(mm) = plot(t_p0, (v_p0+v_p1)/2, 'Color', cols(mm,:));

    % plot the settling of just a single particle in a dashed line
    cd([base,cases{mm},'/1prt'])
    [time, y_p, v_p] = settling(0);
    plot(time, v_p,'--', 'Color', cols(mm,:))
end

xlim([0 100])

xlabel('$t/\tau$')
ylabel('$w_p/w_s$')

leg = legend(p, labs);
leg.Location = 'SouthEast';
leg.Box = 'off';
figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_settling_gamma_%s_nice',angle_dist);
print_figure(fname,'format','pdf','size',[6 4])
%cd('..')

