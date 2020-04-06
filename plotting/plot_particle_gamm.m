% compare the particle separation for different stratifications (gamma)

clear('p')

%base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';
angle_dist = 's2_th45';
cases = {...
    'gamm0.1',...
    ...%'gamm0.3',...
    'gamm0.5',...
    'gamm0.7',...
    'gamm0.9',...
    };

style = 'sep';

switch style
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
        case 'settling'
            plot_settling(1);
        case 'sep'
            p(mm) = plot_particle_separation(0, 1, false, true);
        case 'drift'
            p(mm) = plot_particle_drift(0, 1, false, true);
    end
end

try
    leg = legend(p, cases);
catch
    leg = legend(cases);
end
leg.Location = 'best';

check_make_dir('../../figures')
cd('../../figures')
fname = sprintf('part_%s_gamma_%s',style,angle_dist);
print_figure(fname,'format','pdf','size',[6 4])
%cd('..')

