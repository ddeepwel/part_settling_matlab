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

for mm = 1:length(cases)
    cd([base,cases{mm},'/',angle_dist])

    [time, y_p, v_p] = settling(1);
    plot(time, v_p)
end

xlabel('$t/\tau$')
ylabel('$w_p/w_s$')

leg = legend(labs);
leg.Location = 'best';
leg.Box = 'off';
figure_defaults

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_settling_gamma_%s_nice',angle_dist);
print_figure(fname,'format','pdf','size',[6 4])
%cd('..')

