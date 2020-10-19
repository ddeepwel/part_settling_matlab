% plot vertical and lateral speeds as given by Kynch


[m1, n1] = kynch_factor(1/2);
[m2, n2] = kynch_factor(1/4);
[m3, n3] = kynch_factor(1/8);

theta = linspace(0,90,1024);

u_v1 = n1 + m1 * cosd(theta);
u_h1 =      m1 * sind(theta).*cosd(theta);
u_v2 = n2 + m2 * cosd(theta);
u_h2 =      m2 * sind(theta).*cosd(theta);
u_v3 = n3 + m3 * cosd(theta);
u_h3 =      m3 * sind(theta).*cosd(theta);


figure(44)
clf
subplot(1,2,1)
hold on
plot(theta, u_v1)
plot(theta, u_v2)
plot(theta, u_v3)
xlim([0 90])
ylim([1 1.4])
xlabel('$\theta$ ($^\circ$)')
ylabel('$u_v/w_s$')
leg = legend({'$\tilde{s} = 1/4$','$\tilde{s} = 1/8$','$\tilde{s} = 1/16$'},'Interpreter','Latex');
leg.Box = 'off';
leg.Location = 'NorthEast';
pos = leg.Position;
pos(2) = pos(2) + 0.01;
leg.Position = pos;
ax = gca;
set(gca,'XMinorTick','on','YMinorTick','on')
xticks(0:45:90)
yticks(1:0.1:1.4)
ax.XAxis.MinorTickValues = 22.5:45:90;
ax.YAxis.MinorTickValues = 1.05:0.1:1.4;
xlab = -0.22;
zlab = 0.88;
text(gca,xlab,zlab,subplot_labels(1),...
        'Color','k','Units','normalized','Interpreter','Latex')

subplot(1,2,2)
hold on
plot(theta, u_h1)
plot(theta, u_h2)
plot(theta, u_h3)
xlim([0 90])
xlabel('$\theta$ ($^\circ$)')
ylabel('$u_h/w_s$')
ax = gca;
set(gca,'XMinorTick','on','YMinorTick','on')
xticks([0:45:90])
yticks(0:0.02:0.08)
ax.XAxis.MinorTickValues = 22.5:45:90;
ax.YAxis.MinorTickValues = 0.01:0.02:0.08;
xlab = -0.26;
zlab = 0.88;
text(gca,xlab,zlab,subplot_labels(2),...
        'Color','k','Units','normalized','Interpreter','Latex')

figure_defaults();
cd('/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/figures')
print_figure('kynch','format','pdf','size',[7 3])
