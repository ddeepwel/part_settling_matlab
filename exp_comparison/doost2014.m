% find parties parameters for an input Froude number for figure 3 in Doost 2014
% (single particle, linear stratification)

Fr_doost = 1/0;
Lz_Dp = 80;

% fixed parameters
Re_doost = 14.1;
g = 9.81;
nu = 1e-6;
rho_s = 1.14;

Pr_doost = 700;

% calculated parameters
Re = Re_doost;
grav = 18 / (rho_s - 1) / Re;
Pe = Pr_doost * Re;
Ri = Fr_doost^(-2) * Lz_Dp;
y_0 = 0.75 * Lz_Dp;


% print info
fprintf('Re    = %0.5g\n', Re);
fprintf('rho_s = %0.5g\n', rho_s);
fprintf('grav  = %0.5g\n', grav);
fprintf('Pe    = %0.5g\n', Pe);
fprintf('Ri    = %0.5g\n', Ri);
fprintf('y_0   = %0.5g\n', y_0);
