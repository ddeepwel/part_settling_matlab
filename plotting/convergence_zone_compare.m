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
    
figure(16)
clf
hold on
cols = default_line_colours();

for mm = 1:Ndirs
    cd([base,strats{mm},'/1prt_dx25'])
    load('convergent_dist')
    % p(mm) = plot(time,dist);
    % col = p(mm).Color;
    % col(4) = 0.2;
    % p(mm).Color = col;

    % find the depths associated for the particular time
    [t,yp] = settling;
    for ii = 1:length(time)
        yp_ind = nearest_index(t,time(ii));
        y_p(ii) = yp(yp_ind);
    end
    y_p = y_p - 24;

    % find index to t=6
    %ind = nearest_index(time,6);
    %min_dist(mm) = min(dist(ind:end));
    %a = dist(ind:end);
    %min_dist(mm) = min(a);
    %p2(mm) = plot(time(ind:end),dist(ind:end),'Color',cols(mm,:));

    % find indices when particle is at the interface
    %p2(mm) = plot(y_p,dist,'Color',cols(mm,:));
    [~,ind] = min(dist);
    p2(mm) = plot(y_p(ind:end),dist(ind:end),'Color',cols(mm,:));
end

%plot([1 1]*6, [0 12],'k')
text(gca,6,0,'*','VerticalAlignment','top');
leg = legend(p2, leg_hand);
leg.Box = 'off';

%xlabel('$t/\tau$')
xlabel('$z/D_p$')
ylabel('$h_\mathrm{conv}/D_p$')
%xlim([0 100])
xlim([-25 0])
ylim([0 18])

figure_defaults()

%figure(18)
%clf
%plot(0.1:0.2:0.7,min_dist)
%figure_defaults()
