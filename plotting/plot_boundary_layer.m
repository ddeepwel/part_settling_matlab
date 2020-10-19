% plot the boundary layer of a particle at time t_i


t_i = 25;

base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/';
cases_Re = {'Re0.25','Re1_8','Re1_16'};
spec = {'s2_th90_Re_case','s2_th90','s2_th90'};

figure(50)
clf
hold on

for mm = 1:length(cases_Re)
    direc = [base,cases_Re{mm},'/gamm0.9/',spec{mm}];
    disp(direc)
    cd(direc)

    % find where particle is at t_i
    particle_data = check_read_dat('mobile_1');
    t1 = particle_data.time;
    x1 = particle_data.x;
    y1 = particle_data.y;
    z1 = particle_data.z;
    t1_ind = nearest_index(t1, t_i);
    xp = x1(t1_ind);
    yp = y1(t1_ind);
    zp = z1(t1_ind);

    % get settling velocity
    Dmat = FiniteDiff(t1, 1, 2, true, false); % some cases have variable time step 
    v1 = Dmat * y1;
    v_settling = v1(t1_ind);

    % get velocity field
    t2d = get_output_times('Data2d');
    t2d_ind = nearest_index(t2d,t_i) -1;
    [v2d, vf, x2d, y2d, xy_p] = plot_stat2d('xy', 'v', t2d_ind,50+mm);
    % check to see if particles match
    if [xp yp] ~= xy_p
        error('particle positions do not match')
    end

    % find horizontal slice
    y_ind = nearest_index(y2d,yp);
    v1d = squeeze(v2d(:,y_ind));
    xLind = nearest_index(x2d,xp+0.5)-1;

    par = read_params();
    dx = (par.xmax - par.xmin)/par.NXM;

    figure(50)
    plot(x2d(xLind:end) -(xp+0.5) +dx, v1d(xLind:end) - v_settling)
end

xlim([0 3])
xlabel('$r/D_p - 1/2$')
ylabel('$w - w_p$','Interpreter','Latex')

figure_defaults()
