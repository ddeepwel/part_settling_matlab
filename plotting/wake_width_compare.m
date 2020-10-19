% compare the minimum wake widths for different stratification cases

clear all

base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/';
strats = {
'gamm0.9',...
'gamm0.7',...
'gamm0.5',...
'gamm0.3',...
    };
leg_hand = {
'$\Gamma=0.1$',...
'$\Gamma=0.3$',...
'$\Gamma=0.5$',...
'$\Gamma=0.7$',...
    };

Ndirs = length(strats);
    
figure(17)
clf
hold on

for mm = 1:Ndirs
    cd([base,strats{mm},'/1prt_dx25'])
    load('wake_width')
    %plot(time,width)

    % find the depths associated for the particular time
    [t,yp] = settling;
    for ii = 1:length(time)
        yp_ind = nearest_index(t,time(ii));
        y_p(ii) = yp(yp_ind);
    end
    y_p = y_p - 24;

    p2(mm) = plot(y_p,width);

    % find index to t=6
    ind = nearest_index(time,6);
    min_width(mm) = min(width(ind:end));
end

leg = legend(p2, leg_hand);
leg.Box = 'off';

%xlabel('$t/\tau$')
xlabel('$z/D_p$')
ylabel('$W_\mathrm{wake}/D_p$')
%xlim([0 100])
xlim([-25 0])
%ylim([0 18])

figure_defaults()

%plot([1 1]*6, [0 12],'k')

%figure(18)
%clf
%plot(0.1:0.2:0.7,min_width)
