function vel = St_velocity(rho_p, Dp)
% return the Stokes settling velocity

rho_0 = 1;
g = 9.81;
nu = 1e-6;

vel = 1/18 * (rho_p - rho_0)/rho_0 * g * Dp^2 / nu;

