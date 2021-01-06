% compare the interface for cases initialized at separate distances
% to the interface

base = '/scratch/ddeepwel/bsuther/part_settling/comparisons_and_checks/dist2interface_check/';
dirs = {'L3','L10'};

figure(34)
clf

%%%%%% left
% 3 Dp above interface
cd([base,dirs{1}])
[dat,vf,x,y,xy_p] = plot_stat2d('xy','c0',0,96,'auto','contour');
xy_p(2) = xy_p(2) - 24;

figure(34)
subplot(2,2,1)
contour(x,y-24,dat',linspace(0.1,0.9,9))
viscircles(xy_p, 0.5, 'Color', [0 0 0], 'LineWidth', 1);
axis([-5 5 -3 5])
caxis([-1 1])
ylabel('$z/D_p$')
title('$h_p=3D_p$')

% mid-interface
[dat,vf,x,y,xy_p] = plot_stat2d('xy','c0',16,96,'auto','contour');
xy_p(2) = xy_p(2) - 24;

figure(34)
subplot(2,2,3)
contour(x,y-24,dat',linspace(0.1,0.9,9))
viscircles(xy_p, 0.5, 'Color', [0 0 0], 'LineWidth', 1);
axis([-5 5 -3 5])
caxis([-1 1])
ylabel('$z/D_p$')
xlabel('$x/D_p$')

figure(33)
clf
contour(x,y-24,dat',linspace(0.1,0.9,9),'b')
viscircles(xy_p, 0.5, 'Color', 'b', 'LineWidth', 1);
axis([-5 5 -3 5])
caxis([-1 1])
ylabel('$z/D_p$')
xlabel('$x/D_p$')




%%%%%% right
% 3 Dp above interface
cd([base,dirs{2}])
[dat,vf,x,y,xy_p] = plot_stat2d('xy','c0',33,96,'auto','contour');
xy_p(2) = xy_p(2) - 17;

figure(34)
subplot(2,2,2)
contour(x,y-17,dat',linspace(0.1,0.9,9))
viscircles(xy_p, 0.5, 'Color', [0 0 0], 'LineWidth', 1);
axis([-5 5 -3 5])
caxis([-1 1])
title('$h_p=10D_p$')

% at interface
[dat,vf,x,y,xy_p] = plot_stat2d('xy','c0',49,96,'auto','contour');
xy_p(2) = xy_p(2) - 17;

figure(34)
subplot(2,2,4)
%hold on
contour(x,y-17,dat',linspace(0.1,0.9,9))
viscircles(xy_p, 0.5, 'Color', [0 0 0], 'LineWidth', 1);
axis([-5 5 -3 5])
caxis([-1 1])
xlabel('$x/D_p$')


figure(33)
hold on
contour(x,y-17,dat',linspace(0.1,0.9,9),'g')
viscircles(xy_p, 0.5, 'Color', 'g', 'LineWidth', 1);
axis image
axis([-5 5 -3 3])
caxis([-1 1])
figure_defaults()


figure(34)
colormap(cmocean('tempo'))
figure_defaults()
