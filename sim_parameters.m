function parms = sim_parameters(Re, gamm, s, theta)
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

% particle-pycnocline distance
part_pyc_dist = 3;

x1 = 0;
y1 = 27;
x2 =      s * sind(theta);
y2 = y1 - s * cosd(theta);

pyc_location = y2 - part_pyc_dist;
s1 = pyc_location - 2;
s2 = pyc_location;
s3 = pyc_location + 2;

parms.rho_1 = rho_1;
parms.nu    = nu;
parms.g     = g;
parms.Dp    = Dp;
parms.rho_p = rho_p;
parms.gtilde= gtilde;
parms.Ri    = Ri;
parms.Pe    = Pe;
parms.pyc_location = pyc_location;

fprintf('rho_s   = %0.4g\n', rho_p/rho_1);
fprintf('grav    = %0.4g\n', gtilde);
fprintf('Pe      = %0.4g\n', Pe);
fprintf('Ri      = %0.5g\n', Ri);
fprintf('pyc_loc = %0.5g\n', pyc_location);
fprintf('y_slices= %0.5g, %0.5g, %0.5g\n',s1,s2,s3);
fprintf('particle positions:\n');
fprintf('  P1:    %6.5g %6.5g\n', x1, y1);
fprintf('  P2:    %6.5g %6.5g\n', x2, y2);
