% compare the settling from Parties and Camassa 2010


%base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/mordant/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/comparisons_and_checks/';

sim_cases = {'mordant/midres','tencate/try1'};

% non-dimensionalizations for the experiment
exp_file = {'fig7_vel_new.csv',...
    'fig5b_Re1_5.csv'};

cols = default_line_colours();

figure(97)
clf
hold on

for mm = 1:length(sim_cases)
    subplot(3,2,[mm mm+2])
    hold on
    if mm == 1
        ws = 0.0741;
        Dp = 0.5e-3;
    else
        ws = 0.038;
        Dp = 0.015;
    end
    tstar = Dp / ws;

    cd([base,sim_cases{mm}])
    [t,y,v] = settling;
    p1 = plot(t,v,'Color', cols(mm,:));
    plot([0 50],[1 1]*-1,'Color',[1 1 1]*0.5);

    % experiment
    if mm == 1
        dat = readtable([base,'/mordant/mordant/',exp_file{mm}]);
    else
        dat = readtable([base,'/tencate/tencate/',exp_file{mm}]);
    end
    exp_time = dat.Var1;
    exp_vel  = dat.Var2;
    if mm == 1
        p2 = plot(exp_time / tstar/1000, -exp_vel / ws,'k--');
    else
        p2 = plot(exp_time / tstar, exp_vel / ws,'k.');
    end

    if mm == 1
        ylabel('$w_p / w_\mathrm{max}$','Interpreter','latex')
        legend([p1 p2],'Present study','Mordant \& Pinton (2000)')
        legend('boxoff')
        xlim([0 25])
        ylim([-1.2 0])
    else
        legend([p1 p2],'Present study','ten Cate \emph{et al.} (2002)')
        legend('boxoff')
        xlim([0 6])
        ylim([-1.2 0])
        yticklabels([])
    end
    xticklabels([])

    ax = subplot(3,2,mm+4);
    hold on
    if mm == 1
        v_sim = interp1(t,v, exp_time / tstar/1000);
        plot(exp_time(2:end) / tstar/1000, v_sim(2:end) ./ (-exp_vel(2:end)/ws), 'k-')
        xlim([0 25])
        ylabel('relative error')
    else
        v_sim = interp1(t,v, exp_time / tstar);
        plot(exp_time / tstar, v_sim ./ (exp_vel/ws), 'k.')
        xlim([0 6])
        ylim([0.9 1.5])
        ax.YAxis.MinorTick = 'on';
    end
    plot([0 50],[1 1]*1,'Color',[1 1 1]*0.5);
    xlabel('$t / \tau$')
    shift_axis(0,0.02)

end

figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
print_figure('mordant_tencate_error','format','pdf','size',[7.5 4])
cd(orig_dir)
