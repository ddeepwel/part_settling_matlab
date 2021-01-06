% compare the settling for particles that are initializedat different distances from
% the interface


%base = '/scratch/ddeepwel/bsuther/part_settling/comparisons_and_checks/dist2interface_check/';
%dirs = {'L3','L4','L5','L6','L10'};
base = '/scratch/ddeepwel/bsuther/part_settling/comparisons_and_checks/dist2interface_check/';
gamm = {'gamm0.9/','gamm0.5/'};
dirs = {{'L3','L6','L10'},{'L3','L6','L10'}};

leg_lab = {...
    '$h_p=3 D_p$',...
    ...%'$h_p=4 D_p$',...
    ...%'$h_p=5 D_p$',...
    '$h_p=6 D_p$'...
    '$h_p=10 D_p$'...
    };

ttl = {'$\Gamma=0.1$','$\Gamma=0.5$'};

figure(33)
clf
%subplot(2,1,2)
%hold on

for nn = 1:length(gamm)
subplot(1,2,nn)
hold on

for mm = 1:length(dirs{nn})
    cd([base,gamm{nn},dirs{nn}{mm}])
    [time, y_p, v_p] = settling;
    %[~,sep,sep_vel] = particle_separation;

    % find where the second peak in velocity is and use this as the origin
    % the second peak is where the particles are slowest while passing through the interface
    
    % ignore the first 2 time units
    t2_ind = nearest_index(time,2);

    % max
    %[max_val, pos, ind] = find_wave_max(time(t2_ind:end), v_p(t2_ind:end));
    [~,ind] = max(v_p(t2_ind:end));
    ind = ind(1) + t2_ind - 1;

    %subplot(2,1,1)
    plot(time - time(ind), -v_p)

    %subplot(2,1,2)
    %plot(time-time(ind), sep);

end
xlabel('$(t-t_0)/\tau$')
title(ttl{nn})
end

leg_hand = legend(leg_lab);
%leg_hand.Location = 'SouthEast';


subplot(1,2,1)
ylabel('$w_p/w_s$')
%subplot(2,1,1)
%ylabel('$s$')


figure_defaults();

check_make_dir('../figures/')
cd('../../figures/')
print_figure('check_dist2pyc','format','pdf','size',[8 3])

