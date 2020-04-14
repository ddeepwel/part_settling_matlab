% compare the particle settling for different stratifications (gamma)

clear('p')

base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/Re0.125/';
gamm = 'gamm0.9';
cases = {...
    's2_th90',...
    's2_th67.5',...
    's2_th45',...
    's2_th22.5',...
    's2_th0',...
    };

labs = {...
    '$\theta = 90^\circ$',...
    '$\theta = 67.5^\circ$',...
    '$\theta = 45^\circ$',...
    '$\theta = 22.5^\circ$',...
    '$\theta = 0^\circ$',...
    };

figure(165)
clf
hold on

cols = default_line_colours();

% plot the settling of the center of mass of the particles 
cd([base,gamm,'/1prt'])
[time, y_p, v_p] = settling(0);
p0 = plot(time, v_p,'k-');

for mm = 1:length(cases)
    cd([base,gamm,'/',cases{mm}])
    [t_p0, y_p0, v_p0] = settling(0);
    [t_p1, y_p1, v_p1] = settling(1);
    p(mm) = plot(t_p0, (v_p0+v_p1)/2, 'Color', cols(mm,:));
end

xlim([0 25])

xlabel('$t/\tau$')
ylabel('$w_p/w_s$')

leg = legend([p0, p], ['1 particle',labs]);
leg.Location = 'NorthEast';
leg.Box = 'off';
figure_defaults

check_make_dir('../figures')
cd('../figures')
fname = sprintf('part_settling_theta_%s_nice',strrep(gamm,'.',''));
print_figure(fname,'format','pdf','size',[6 4])
%cd('..')

