function [max_entrain, max_entrain_time] = max_entrain_vol()
% measure the maximum entrained fluid

load('entrained_fluid')
volume = volume * 6/pi;
[max_entrain, max_entrain_ind] = max(volume);
max_entrain_time = time(max_entrain_ind);
