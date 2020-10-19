% for vertically aligned particles


tm = 3;
g3 = 0.1;
g2 = -0.15;
g1 = -g2 / tm^2;
tb = tm + sqrt((g3-g2)/g1);

f1 = @(t,s) (g1 * (t-tm).^2 + g2) .* (t<tb);
f2 = @(t,s) g3 * (t>tb);
forces = @(t,s) f1(t,s) + f2(t,s);

[t,s] = ode45(@(t,s) forces(t,s),[0 30],1);
