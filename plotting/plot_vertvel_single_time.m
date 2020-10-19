% plot the vertical velocity above a single particle
% this is to show how the stratification changes the velocity structure


base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/';
gamm_dirs = {
'gamm0.1',...
'gamm0.3',...
'gamm0.5',...
'gamm0.7',...
'gamm0.9',...
'gamm1.0'
};
gs = [0.1:0.2:0.9, 1.0];

ii = 40;

figure(73)
clf
figure(74)
clf
hold on

for mm = 1:length(gs)
    cd([base,gamm_dirs{mm},'/1prt_dx25'])

    % plot 2D structure
    [data, vf, xvar, yvar, xy_p] = plot_stat2d('xy','v',ii);
    [nx,ny] = size(data);
    figure(73)
    subplot(2,3,mm)
    pcolor(xvar,yvar,data'.*(1-vf'))
    shading flat
    ylim([10 30])
    colorbar
    mx = max(abs(data(:)));
    caxis([-1 1]*mx)
    title(sprintf('$\\Gamma = %0.2g$',1-gs(mm)))


    % plot 1D structure
    figure(74)
    plot(data(round(nx/2),:).*(1-vf(round(nx/2),:)),yvar)
    gs2{mm} = sprintf('$\\Gamma = %0.2g$',1-gs(mm));
end

leg = legend(gs2);
leg.Location = 'best';

figure_defaults()

figure(73)
figure_defaults()
colormap(cmocean('balance'))
