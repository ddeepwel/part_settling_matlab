function [time, drift, drift_vel] = particle_drift(p1, p2)
% return the particle pair's horizontal motion as a time series

if nargin == 0
    p1 = 0;
    p2 = 1; 
end

p1_file = sprintf('mobile_%d', p1);
p2_file = sprintf('mobile_%d', p2);
p1_data = check_read_dat(p1_file);
p2_data = check_read_dat(p2_file);

time = p1_data.time;

drift = (p1_data.x + p2_data.x)/2 ...
      + (p1_data.z + p2_data.z)/2;

Dmat = FiniteDiff(time,1,2,true,false);
drift_vel = Dmat * drift;
