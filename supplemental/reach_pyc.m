function reach_pyc = reached_pyc()
% check if a particle has reached the pycnocline

particle_files = dir('mobile_*.dat');
N_files = length(particle_files);

% height of pycnocline
params = read_params();
sig   = params.sig_profile;
y_pyc = params.pyc_location;
H = y_pyc + sig;

height = zeros(1,N_files);
for mm = 1:N_files
    fname = sprintf('mobile_%d', mm-1);
    p = check_read_dat(fname);
    height(mm) = min(p.y);
end

if min(height) < H
    reach_pyc = true;
else
    reach_pyc = false;
end

