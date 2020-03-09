function y_trail = trailing_position(dist, file_prefix) 
% find the index for a distance trailing behind the particle 

if nargin == 1
    file_prefix = 'Data2d';
end

file_name = 'mobile';
if exist([file_name,'.mat'], 'file') == 2
    % load cleaned data, if it exists
    diag_file = [file_name,'.mat'];
    particle_data = load(diag_file);
    % also load the txt file to check if mat file is up to date
    diag_dat = readtable([file_name,'.dat']);
elseif exist([file_name,'.dat'], 'file') == 2
    % otherwise read raw data (this will likely be fine, unless a restart caused overlapping data)
    diag_file = [file_name,'.dat'];
    particle_data = readtable(diag_file);
else
    error('mobile particles file not found.')
end

part_time = particle_data.Var1;
part_pos  = particle_data.Var4;
output_times = get_output_times(file_prefix);
Noutputs = length(output_times);

y_trail = zeros(Noutputs,1);

for mm = 1:Noutputs
    time = output_times(mm);

    t_ind = nearest_index(part_time, time);
    y_trail(mm) = part_pos(t_ind) + dist;
end
