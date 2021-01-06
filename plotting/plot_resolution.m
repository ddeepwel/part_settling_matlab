% plot the resolution test for the reviewer


base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/';
cases = {'gamm0.9/s2_th0_dx15',...
    'gamm0.9/s2_th0_dx30',...
    'gamm0.3/s2_th90_dx25',...
    'gamm0.3/s2_th90_dx40'};

leg = {'$\Gamma=0.1,~\theta=0^\circ, ~D_p/\Delta x = 15$',...
       '$\Gamma=0.1,~\theta=0^\circ, ~D_p/\Delta x = 30$',...
       '$\Gamma=0.7,~\theta=90^\circ,~D_p/\Delta x = 25$',...
       '$\Gamma=0.7,~\theta=90^\circ,~D_p/\Delta x = 40$'};

figure(89)
clf
hold on

for mm = 1:length(cases)
    cd([base,cases{mm}])

    [time, yp1, wp1] = settling(0);
    [time, yp2, wp2] = settling(1);
    wp = (wp1+wp2)/2;

    if mm == 1
        ind = nearest_index(time,29);
        plot(time(1:ind), -wp(1:ind))
    elseif mm == 2
        plot(time, -wp)
    else
        plot(time, -wp, '--')
    end
end

xlabel('$t/\tau$')
ylabel('$w_p/w_s$')
xlim([0 80])


legend(leg)
legend('location','NorthEast')

figure_defaults();

cd('../../figures')
print_figure('resolution','format','pdf','size',[7 5]);
