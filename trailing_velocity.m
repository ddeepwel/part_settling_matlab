function [time, vel] = trailing_velocity(dist);
% find the velocity trailing behind a falling particle

y_trail_pos = trailing_position(dist);

load('xsection_vert_00.mat')

for ii = 1:length(y_trail_pos)
    y_ind = nearest_index(y, y_trail_pos(ii));
    vel(ii) = v_ty(ii,y_ind);
end
