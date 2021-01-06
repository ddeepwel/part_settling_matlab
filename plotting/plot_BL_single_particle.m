% plot the viscous boundary layer for an individual
% particle in a homogeneous fluid


t_i = 2;
%t_i = 4;

base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/';
cases_Re = {'Re0.25','Re1_8','Re1_16'};
spec = 'gamm1.0/1prt_dx25';
suffix = {'','','_wide'};
leg_hand = {'$Re=1/4$','$Re=1/8$','$Re=1/16$'};

figure(159)
clf
hold on

for mm = 1:length(cases_Re)
    direc = [base,cases_Re{mm},'/',spec,suffix{mm}];
    disp(direc)
    cd(direc)

    % find where particle is at t_i
    particle_data = check_read_dat('mobile_0');
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

    figure(159)
    plot(x2d(xLind:end) -(xp+0.5) +dx, v1d(xLind:end) - v_settling)

end

% add stokes and Oseen BL flow

Re = 1/4;
r = [x2d(xLind+1:end); transpose(10:5:40)];
R = 1/2;   % to scale by radius not diameter ( r is scaled by diameter)
us = -v_settling;
% Oseen solution ( it's not any different than the Stokes)
u_Oseen_vel = us * (1 - 3/4 * R./r .* exp(-Re/4*r/R) - 1/4 * R^3./r.^3);
plot(r-0.5,u_Oseen_vel,'k--')
%u_Oseen_vel = us * (1 - 3/4 * R./r .* exp(-Re/4/4*r/R) - 1/4 * R^3./r.^3); % Re/4
%plot(r-0.5,u_Oseen_vel,'k:')
% Stokes solution
u_stokes_vel = us * (1 - 3/4 * R./r - 1/4 * R^3./r.^3);
plot(r-0.5,u_stokes_vel,'r--')


leg_hand = cat(2,leg_hand,{'Oseen, $Re=1/4$','Stokes'});
legend(leg_hand)
legend('location','best')

figure_defaults()
xlabel('$r/D_p-1/2$')
ylabel('$w/w_s$')
xlim([0 6])
ylim([0 1])


% check boundary layer thickness for different Reynolds numbers
Ren = 1./2.^(1:8)
for kk = 1:length(Ren);
    Re = Ren(kk);
    u_Oseen_vel = us * (1 - 3/4 * R./r .* exp(-Re/4*r/R) - 1/4 * R^3./r.^3);
    ind = nearest_index(u_Oseen_vel,0.8);
    dBL(kk) = r(ind);
end

figure(77)
clf
plot(Ren,dBL)
