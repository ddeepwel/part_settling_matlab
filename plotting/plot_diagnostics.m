% plot PARTIES diagnostics

diagnos = table2struct(readtable('diagnostics.dat'), 'ToScalar', true);

iter   = diagnos.Iter;
time   = diagnos.Time;
max_c0 = diagnos.Max_c0;
min_c0 = diagnos.Min_c0;


figure(20)
clf

subplot(2,1,1)
plot(time, max_c0-1)
ylabel('max $c_0-1$')

subplot(2,1,2)
plot(time, min_c0)
xlabel('$t/\tau$')
ylabel('min $c_0$')

figure_defaults()
