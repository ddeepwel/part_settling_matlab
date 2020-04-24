function [min_sep, min_sep_time] = min_part_sep()
% measure the minimum particle separation

[time, sep, sep_vel] = particle_separation();
[min_sep, min_sep_ind] = min(sep);
min_sep_time = time(min_sep_ind);
