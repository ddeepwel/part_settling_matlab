function tscale = Verso_time_scale(Re, gamm)
% return the time scale for the relaxation of the drag force due to attached
% upper layer fluid from Verso et al. 2019

rho_1 = 1.0;   % g/mL
nu    = 1e-6;  % m^2/s
g     = 9.81;  % m/s^2
Dp    = 80e-6; % m

% density of particle
rho_p = rho_1 * (1 + 18 * nu^2 * Re / g / Dp^3);
rho_2 = rho_p - gamm * (rho_p-rho_1);

% time scale in non-dimensional units
tscale = 13 / gamm * rho_2 / rho_1;
