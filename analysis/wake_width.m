% find the width of the returning flow in the wake of the particle after it has passed through the interface

clear all

tf_ind = last_output('Data2d');
time = get_output_times('Data2d');
time = time(2:end);

for ii = 1:tf_ind
    [dat, vf, xvar,yvar,~] = plot_stat2d('xy','v',ii,97,'auto','pcolor',false);
    max_vel = max(dat(:));
    [cx,cy] = find_contour(xvar,yvar,dat',max_vel/10);
    %hold on
    %plot(cx,cy,'k')

    width(ii) = max(cx) - min(cx);
    completion(ii,tf_ind)
end


figure(17)
clf
plot(time,width)

save('wake_width', 'time', 'width')
