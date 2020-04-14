function [t_pyc, t_pyc_ind] = reach_pyc_time()
% time when a particle reaches the pycnocline

particle_files = dir('mobile_*.dat');
N_files = length(particle_files);

% height of pycnocline
params = read_params();
sig   = params.sig_profile;
y_pyc = params.pyc_location;
H = y_pyc + sig;

ts = zeros(1,N_files);
for mm = 1:N_files
    fname = sprintf('mobile_%d', mm-1);
    p = check_read_dat(fname);
    height = min(p.y);
    if height <= H
        t_ind = nearest_index(p.y,H);
        ts(mm) = p.time(t_ind);
    end
end

t_pyc = min(ts(ts>0));
t_pyc_ind = nearest_index(p.time, t_pyc);

