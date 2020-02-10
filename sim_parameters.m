function parms = sim_parameters(Re, gamm)
% create list of parameters to keep fixed and functions to get the correct varied parameters


rho_1 = 1.0;   % g/mL
nu    = 1e-6;  % m^2/s
g     = 9.81;  % m/s^2
Dp    = 80e-6; % m
Sc    = 700;   % m^2/s

% density of particle
rho_p = rho_1 * (1 + 18 * nu^2 * Re / g / Dp^3);

% non-dim gravity
gtilde = 18 * rho_1 / (rho_p - rho_1) / Re;

% Richardson number
Ri = 18 * (1 - gamm) / Re;

% Peclet number
Pe = Re * Sc;

parms.rho_1 = rho_1;
parms.nu    = nu;
parms.g     = g;
parms.Dp    = Dp;
parms.rho_p = rho_p;
parms.gtilde= gtilde;
parms.Ri    = Ri;
parms.Pe    = Pe;

fprintf('rho_s = %0.4g\n', rho_p/rho_1);
fprintf('grav  = %0.4g\n', gtilde);
fprintf('Pe    = %0.4g\n', Pe);
fprintf('Ri    = %0.4g\n', Ri);
