% add points to Kynch plot for inertial particles

plot_kynch


%base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/gamm1.0/';
base = '/Volumes/2part_settling/2particles/sigma1/Re1_4/gamm1.0/';
dirs = {{...
    's2_th0_dx25',...
    's2_th22.5_dx25',...
    's2_th45_dx25',...
    's2_th67.5_dx25',...
    's2_th90_dx25'...
    },{...
    's4_th0_dx25',...
    's4_th22.5_dx25',...
    's4_th45_dx25',...
    's4_th67.5_dx25',...
    's4_th90_dx25'...
    },{...
    's8_th0_dx25',...
    's8_th22.5_dx25',...
    's8_th45_dx25',...
    's8_th67.5_dx25',...
    's8_th90_dx25'...
    }};

th = [0 22.5 45 67.5 90];

%cd([base,dirs{1}])
%par = read_params();
%rho_s = par.rho_s;
%g = 9.81;
%Dp = 80e-6;
%nu = 1e-6;
%w_stokes = 1/18 * (rho_s - 1) * g * Dp^2/ nu;

% settling of a single particle with Re=1/4
cd([base,'1prt_dx25'])
[t1,y1,w1] = settling;
wsRe1_4 = w1(1000);

tc = 3;

figure(44)
cols = default_line_colours();

for nn = 1:length(dirs)
    clear w_settle u_drift
    for mm = 1:length(dirs{nn})
        cd([base,dirs{nn}{mm}])

        % settling speed
        [time, x_com, y_com, z_com, Np] = particle_centre_of_mass();
        Dmat = FiniteDiff(time,1,2,true,false);
        w_com = Dmat * y_com;

        % drift speed
        [time, drift, drift_vel] = particle_drift(0, 1);

        tind = nearest_index(time, tc);
        w_settle(mm) = w_com(tind);
        u_drift(mm) = drift_vel(tind);
    end

    subplot(1,2,1)
    hold on
    %plot(th, -w_settle, 's','Color',cols(nn,:))
    plot(th,  w_settle/wsRe1_4, 'o','Color',cols(nn,:))
    ylim([0.90 1.5])
    yticks(0.8:0.1:1.5)

    subplot(1,2,2)
    hold on
    %plot(th,  u_drift, 's','Color',cols(nn,:))
    plot(th, -u_drift/wsRe1_4, 'o','Color',cols(nn,:))
    ylim([0.0 0.1])
    yticks(0:0.02:0.1)
end

leg = legend([p1 p2 p3], {'$\tilde{s} = 1/4,~(s/D_p=1)$','$\tilde{s} = 1/8,~ (s/D_p=3)$','$\tilde{s} = 1/16,~(s/D_p=7)$'},'Interpreter','Latex');

cd('../figures')
print_figure('kynch_with_inertia','format','pdf','size',[8 3]);
