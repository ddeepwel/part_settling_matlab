% find the width of the returning flow in the wake of the particle after it has passed through the interface

clear all

tf_ind = last_output('Data2d');
time = get_output_times('Data2d');
time = time(2:end);

for ii = 1:tf_ind
    [dat, vf, xvar,yvar,~] = plot_stat2d('xy','v',ii,97,'auto','pcolor',false);
    if ii == 1
        nx = length(xvar);
        ny = length(yvar);
        Dmat = FiniteDiff(yvar,1,2);
    end
    v = dat(round(nx/2),:).*(1-vf(round(nx/2),:));
    w_z = Dmat * v';

    % particle position
    [t_p, y_p, v_p] = settling();
    t_p_ind = nearest_index(t_p,time(ii));
    indb = nearest_index(yvar,y_p(t_p_ind)+0.5);
    indt = indb+10;
    while w_z(indt) > 0 && (indt<ny)
        indt = indt+1;
    end
    %indt = nearest_index(w_z(indb:end),0); % might not work right away
    %dist(ii) = yvar(indt+indb-1) - yvar(indb);
    dist(ii) = yvar(indt) - yvar(indb);

    completion(ii,tf_ind)
end


figure(17)
clf
plot(time,dist)

save('convergent_dist', 'time', 'dist')
