% plot PARTIES diagnostics

%diagnos = table2struct(readtable('diagnostics.dat'), 'ToScalar', true);
diagnos = check_read_dat('diagnostics');

iter   = diagnos.iter;
time   = diagnos.time;
max_c0 = diagnos.max_c0;
min_c0 = diagnos.min_c0;


figure(20)
clf
hold on

%subplot(2,1,1)
plot(time, max_c0-1)
plot(time, abs(min_c0))
xlabel('$t/\tau$')
legend('max $c_0-1$','$|$min $c_0|$')
legend('boxoff')

figure_defaults()
check_make_dir('figures')
cd('figures')
print_figure('diagnos_c0','format','pdf','size',[6 4])
cd('..')

if exist('diagnostics_vel.dat') == 2
    diagnos_vel = check_read_dat('diagnostics_vel');

    max_u = diagnos_vel.max_u;
    min_u = diagnos_vel.min_u;
    max_v = diagnos_vel.max_v;
    min_v = diagnos_vel.min_v;
    max_w = diagnos_vel.max_w;
    min_w = diagnos_vel.min_w;

    figure(21)
    clf
    hold on

    subplot(2,1,1)
    plot(time, [max_u max_v max_w])
    ylabel('max vel')
    subplot(2,1,2)
    plot(time, [min_u min_v min_w])
    ylabel('min vel')
    xlabel('$t/\tau$')
    legend('$u$','$v$','$w$')
    figure_defaults();
end
