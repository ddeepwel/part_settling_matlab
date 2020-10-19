% plot the minimum separation distance

direc = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/compare_data';
cd(direc)

style = 'entrain_mass';
gamm_np = 'gamm09';

switch style
    case 'sep'
        load(['min_sep_',gamm_np,'.mat'])
        min_sep = min_sep - 1; % remove the particle radii
        data = min_sep;
        fname = ['sep_s_theta_',gamm_np];
    case 'settling'
        load(['min_settling_',gamm_np,'.mat'])
        data = min_settling_vel;
        fname = ['settling_vel_s_theta_',gamm_np];
    case 'entrain'
        load(['max_entrain_',gamm_np,'.mat'])
        data = max_entrain;
        %fname = ['entrain_s_theta_',gamm_np];
        fname = ['entrain_s_theta_',gamm_np];
    case 'entrain_mass'
        load(['entrain_final_',gamm_np,'.mat'])
        data = entrain_final;
        %fname = ['entrain_s_theta_',gamm_np];
        fname = ['entrain_final_s_theta_',gamm_np];
end
[Ns, Ntheta] = size(data);
ss = ss-1; % subtract the particle radii

figure(88)
clf

cols = cmocean('-thermal');
max_data = max(data(:));
min_data = min(data(:));
%cols = default_line_colours();
for mm = 1:Ns
    for nn = 1:Ntheta
        col_row = round((data(mm,nn)-min_data)/(max_data-min_data)*255 + 1);
        p = polarplot(pi/2 + thetas(nn)/180*pi, ss(mm),'o','Color',cols(col_row,:));
        if mm == 1 && nn == 1
            hold on
        end
        lab = sprintf('%2.2g',data(mm,nn));
        text(pi/2 + thetas(nn)/180*pi, ss(mm),lab,...
        'HorizontalAlignment','right','VerticalAlignment','bottom');
        switch style
            case 'entrain_mass'
                if need_longer(mm,nn) == 1
                    polarplot(pi/2 + thetas(nn)/180*pi,ss(mm),'kx');
                end
            otherwise
                if near_bottom(mm,nn) == 1
                    polarplot(pi/2 + thetas(nn)/180*pi,ss(mm),'kx');
                end
        end
        p.MarkerFaceColor = p.Color;
        p.MarkerSize = 10;
    end
end
axis([90 180 0 8])

ax = gca;
ax.RAxis.Label.String = '$(s-D_p)/D_p$';
ax.ThetaAxis.Label.String = '$\theta~(^\circ)$';
ax.ThetaAxis.TickValues = 90:30:180;
ax.ThetaAxis.TickLabel = {'0','30','60','90'};

figure_defaults()
cd('../figures')
print_figure(fname,'format','pdf','size',[6 4])

