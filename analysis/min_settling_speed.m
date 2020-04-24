function [min_settling, min_settling_time] = min_settling_speed()
% measure the minimum particle settling speed

[time, y0, v0] = settling(0);
[time, y1, v1] = settling(1);
v = (v0 + v1)/2;
[min_settling, min_settling_ind] = min(v);
min_settling_time = time(min_settling_ind);
