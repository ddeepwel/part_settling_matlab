% Verso model for 1 particle

Re = 1/4;
Gam = 0.3;
rho_p = 1.896;  % actually scaled by rho_1
D_p = 80e-6;    % m
nu = 1e-6;      % m^2/s
g = 9.81;       % m/s^2

A_p = pi/4 * D_p^2;
V_p = pi/6 * D_p^3;
%M_p = rho_p * V_p;
C_D = 0.4 + 24/Re + 6 / (1 + sqrt(Re));

% derived parameters
delta_rho = Gam * (rho_p - 1);
rho_2 = 1 + delta_rho;
v_1 = 1/18 * (rho_p       - 1) * g * D_p^2 / nu; % stokes settling velocity in upper layer
v_2 = 1/18 * (rho_p/rho_2 - 1) * g * D_p^2 / nu; % stokes settling velocity in upper layer
g_tilde = g * D_p /v_1^2;
DA_V = 3/2; % D_p * A_p / V_p

% background stratification
sigma = 1;
z0 = 20;
rho_f = @(z) 1 + delta_rho/2 * (1-erf((z-z0)/sigma));

% V_c
N = sqrt(2*g/(1+rho_2)*delta_rho/(2*sigma));
Fr = v_1 / (N*D_p);
V_c0 = 0.13 * Fr^(3/4); % non-dimensionalized by V_p
t_h = 7.3; %% need to adjust!!!!
%Re_2 = v_2 * D_p/nu;
%t_rec = 13 * D_p^2/ nu / Re_2;
t_rec = 6 * v_1/v_2;
V_c = @(t,z) (z>z0-sigma).*(z<z0+sigma) + (z<z0-sigma) .* exp(-(t-t_h)/t_rec);

% forces
F_wb = @(t,z,v) (rho_f(z)/rho_p - 1) * g_tilde;
F_D  = @(t,z,v) - C_D/2 * DA_V * rho_f(z)/rho_p .* abs(v) .* v;
F_s  = @(t,z,v) (rho_f(z)/rho_p - 1/rho_p) * g_tilde * V_c0 .* V_c(t,z);
forces = @(t,z,v) F_wb(t,z,v) + F_D(t,z,v) + F_s(t,z,v);

odefnc = @(t,y) [y(2); forces(t,y(1),y(2))];

options = odeset('RelTol',1e-6,'MaxStep',0.01);
[t,y] = ode45(@(t,y) odefnc(t,y), [0 30],[23; 0],options);


figure(11)
clf

[t_p,y_p,v_p] = settling;
plot(t_p,v_p)
hold on
plot(t,y(:,2))
