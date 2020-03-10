% setup for figure 1 Doost 2013 particle pair
% side-by-side configuration

% variable parameters
Fr_doost = 20;
Lz_Dp = 20; % vertical length in particle diameters

% fixed parameters
g = 9.81;
nu = 1e-6;
rho_s = 1.14; % rho_s = rho_p / rho_0

Re_doost = 50;
Pr_doost = 700;

% Re = W Dp / nu
Dp = (Re_doost * nu)^(2/3) / (g)^(1/3);
W = sqrt( g * Dp );

Ws = St_velocity(rho_s, Dp);
Re = Ws * Dp / nu;
grav = g * Dp / Ws^2;
Pe = Pr_doost * Re;
Ri = Lz_Dp * W^2/Ws^2 * Fr_doost^(-2);

% particle separation distance
S0 = 1.2;

% particle positions
y_0= 0.75 * Lz_Dp;
x1 = 0;
y1 = y_0;
x2 = x1 + S0;
y2 = y_0;

% print info
fprintf('Re    = %0.5g\n', Re);
fprintf('rho_s = %0.5g\n', rho_s);
fprintf('grav  = %0.5g\n', grav);
fprintf('Pe    = %0.5g\n', Pe);
fprintf('Ri    = %0.5g\n', Ri);
fprintf('y_0   = %0.5g\n', y_0);

fprintf('particle positions:\n');
fprintf('  P1:    %6.5g %6.5g\n', x1, y1);
fprintf('  P2:    %6.5g %6.5g\n', x2, y2);
