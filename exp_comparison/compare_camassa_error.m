% compare the settling from Parties and Camassa 2010

base = '/Volumes/2part_settling/comparisons_and_checks/camassa/';

sim_case = 'fig3_better';

sim_case = 'strat';
    t0 = -5;
sim_case = 'fig3';
    t0 = -1.9;
sim_case = 'fig3_better';
    t0 = 2.9;

exp_file = 'fig3_vel.csv';
w1 = 0.388;
Dp = 2 * 0.635;
tstar = Dp / w1;

cols = default_line_colours();

cd([base,sim_case])
[t,y,v] = settling;

figure(97)
clf
subplot(3,1,[1 2])
hold on

plot([0 25],[1 1]*-1,'Color',[1 1 1]*0.5)

p1 = plot(t,v, 'Color', cols(1,:));

dat = readtable([base,'camassa/',exp_file]);
exp_time = dat.Var1;
exp_vel  = dat.Var2;

p2 = plot(t0 + exp_time / tstar, -exp_vel / w1, 'k--');%, 'Color',cols(2,:));

%grid on
ylabel('$w_p / w_1$')
%title(strrep(sim_case,'_',' '))
xlim([0 20])
ylim([-1.2 -0.5])
xticklabels([])

legend([p1 p2],'Present study','Camassa \emph{et al.} (2010)')
legend('boxoff')

subplot(3,1,3)
hold on
v_sim = interp1(t,v, t0+exp_time/tstar);
plot(t0+exp_time/tstar,v_sim./(-exp_vel/w1),'k-')
plot([0 25],[1 1]*1,'Color',[1 1 1]*0.5)
xlim([0 20])
xlabel('$t / \tau$')
ylabel('relative error')


figure_defaults()

check_make_dir('../figures')
orig_dir = cd('../figures');
%print_figure('Camassa2010_error','format','pdf','size',[6 4])
cd(orig_dir)
