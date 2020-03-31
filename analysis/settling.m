function [time, y_p, vel] = settling(particle_ID)
% get the settling velocity and position of a particle

if nargin == 0
    particle_ID = 0;
end

% Read data
file_name = sprintf('mobile_%d',particle_ID);
particle_data = check_read_dat(file_name);

% get data
time = particle_data.time;
y_p  = particle_data.y;
vel  = particle_data.v;


