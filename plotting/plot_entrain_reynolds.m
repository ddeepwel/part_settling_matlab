% compare the entrainment for different Reynolds number


base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/';
angle_dist = 'gamm0.9/s2_th90';
cases = {...
    'Re0.25',...
    'Re1_8',...
    'Re1_16',...
    };
suffix = {...
    '_Re_case',...
    '',...
    '',...
    };
labs = {...
    '$Re=1/4$',...
    '$Re=1/8$',...
    '$Re=1/16$',...
    };

figure(59)
clf
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

leg = legend(labs);
leg.Location = 'NorthEast';
leg.Box = 'off';
%xlab = -0.2;
%zlab = 0.94;
text(gca,6,0,'*','VerticalAlignment','top');
%text(gca,xlab,zlab,subplot_labels(1),...
%            'Color','k','Units','normalized','Interpreter','Latex')

figure_defaults()

cd('../../../figures')
print_figure('entrain_Re','format','pdf','size',[4.5 3])
