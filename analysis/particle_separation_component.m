function [time, sep_x, vel_x, sep_y, vel_y, sep_z, vel_z] = particle_separation_component(p1, p2)
% return the distance and velocity between 2 particles as a time series in each component

if nargin == 0
    p1 = 0;
    p2 = 1; 
end

% read the particle data
p1_file = sprintf('mobile_%d', p1);
p2_file = sprintf('mobile_%d', p2);
p1_data = check_read_dat(p1_file);
p2_data = check_read_dat(p2_file);

% time
time = p1_data.time;

% separation
sep_x = abs(p1_data.x - p2_data.x);
sep_y = abs(p1_data.y - p2_data.y);
sep_z = abs(p1_data.z - p2_data.z);

% velocity
Dmat = FiniteDiff(time,1,2,true,false);
vel_x = Dmat * sep_x;
vel_y = Dmat * sep_y;
vel_z = Dmat * sep_z;
