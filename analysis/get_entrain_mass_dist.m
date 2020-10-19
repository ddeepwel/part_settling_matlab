function [entrain, entrain_dist] = get_entrain_mass_dist(dist)
% find the entrained mass at the end of the simulation

par = read_params();
Ri = par.richardson;
Re = par.Re;
gam = 1 - Ri * Re / 18;
rho_s = par.rho_s;
z0 = par.pyc_location;

try
    load('entrained_tracer')
    mass = volume * 6/pi;% * (1-gam) * (1-1/rho_s);
catch
    load('entrained_mass')
    mass = M_entrain * 6/pi;% * (1-gam) * (1-1/rho_s);
end
[t_p1, y_p1, v_p1] = settling(0);
t_p_ind = nearest_index(y_p1, z0-dist);
t_m_ind = nearest_index(time, t_p1(t_p_ind));
t_actual = time(t_m_ind);

t_actual_p_ind = nearest_index(t_p1, t_actual);
y_actual = y_p1(t_actual_p_ind);

if z0 - y_actual < dist - 1
    if t_m_ind < length(time)
       t_m_ind = t_m_ind + 1;

       t_actual = time(t_m_ind);
       t_actual_p_ind = nearest_index(t_p1, t_actual);
       y_actual = y_p1(t_actual_p_ind);
   end
end 

% use interp to find the entrainment
%entrain = mass(t_m_ind);
entrain = interp1(time, mass, t_p1(t_p_ind),'spline');
entrain_dist = z0 - y_actual;
