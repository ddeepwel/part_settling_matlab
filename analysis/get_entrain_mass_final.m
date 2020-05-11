function [entrain_final, entrain_final_time] = get_entrain_mass_final()
% find the entrained mass at the end of the simulation

par = read_params();
Ri = par.richardson;
Re = par.Re;
gam = 1 - Ri * Re / 18;
rho_s = par.rho_s;

try
    load('entrained_mass')
    mass = M_entrain * 6/pi;% * (1-gam) * (1-1/rho_s);
catch
    load('entrained_tracer')
    mass = volume * 6/pi;% * (1-gam) * (1-1/rho_s);
end
entrain_final = mass(end-1:end);
entrain_final_time = time(end);
