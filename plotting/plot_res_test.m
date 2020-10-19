% compare the resolution for a variety of cases at a single gamma value
clear all

base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/';

%gamm = 'gamm0.1';
%fname = 'res_test_Gamm09';
%yylim = [0 0.45];
%dirs = {
% {'1prt','1prt_dx25'},...
% {'s2_th0','s2_th0_dx25'},...
% {'s2_th22.5','s2_th22.5_dx25'},...
% {'s2_th45','s2_th45_dx25'},...
% {'s2_th67.5'},...
% {'s2_th90','s2_th90_resdbl'}};

%gamm = 'gamm0.3';
%fname = 'res_test_Gamm05';
%yylim = [0 0.45];
%dirs = {
% {'1prt','1prt_dx25'},...
% {'s2_th0','s2_th0_dx25'},...
% {'s2_th22.5','s2_th22.5_dx25'},...
% {'s2_th45','s2_th45_dx25'},...
% {'s2_th67.5','s2_th67.5_dx25'},...
% {'s2_th90','s2_th90_dx25','s2_th90_dx40'}};

%gamm = 'gamm0.5';
%fname = 'res_test_Gamm05';
%yylim = [0 0.1];
%dirs = {
% {'1prt','1prt_dx25'},...
% {'s2_th0','s2_th0_dx25'},...
% {'s2_th22.5','s2_th22.5_dx25'},...
% {'s2_th45','s2_th45_dx25'},...
% {'s2_th67.5','s2_th67.5_dx25'},...
% {'s2_th90','s2_th90_dx25'}};

%gamm = 'gamm0.7';
%fname = 'res_test_Gamm03';
%yylim = [0 0.05];
%dirs = {
% {'1prt','1prt_dx25'},...
% {'s2_th0','s2_th0_dx25'},...
% {'s2_th22.5','s2_th22.5_dx25'},...
% {'s2_th45','s2_th45_dx25'},...
% {'s2_th67.5','s2_th67.5_dx25'},...
% {'s2_th90','s2_th90_dx25'}};

%gamm = 'gamm0.9';
%fname = 'res_test_Gamm01';
%yylim = [0 0.05];
%dirs = {
% {'1prt','1prt_dx25'},...
% {'s2_th0','s2_th0_dx20','s2_th0_dx30'},...
% {'s2_th22.5','s2_th22.5_dx25'},...
% {'s2_th45_dx25'},...
% {'s2_th67.5','s2_th67.5_dx25'},...
% {'s2_th90','s2_th90_dx25'}};

gamm = 'gamm1.0';
fname = 'res_test_Gamm00';
yylim = [0 0.05];
dirs = {
 {'1prt','1prt_dx25'},...
 {'s2_th0','s2_th0_dx25'},...
 {'s2_th22.5_dx25'},...
 {'s2_th45_dx25'},...
 ...% {'s2_th67.5','s2_th67.5_dx25'},...
 {'s2_th90_dx25'}};

figure(42)
clf
cols = default_line_colours();

for mm = 1:length(dirs)
    clear p1 p2
    for nn = 1:length(dirs{mm});
        cd([base,gamm,'/',dirs{mm}{nn}])

        subplot(5,6,mm)
        if nn == length(dirs{mm})
            hold on
            diagnos = check_read_dat('diagnostics');
            time   = diagnos.time;
            max_c0 = diagnos.max_c0;
            min_c0 = diagnos.min_c0;
            plot(time, max_c0-1)
            plot(time, abs(min_c0))
            xlabel('$t/\tau$')
            if mm == 1
                ylabel('tracer extremes')
            end
            if nn == length(dirs{mm})
                legend('max $\rho''-1$','$|$min $\rho''|$')
                legend('boxoff')
                ylim(yylim)
                title(strrep(dirs{mm}{1},'_','\_'))
            end
        end

        subplot(5,6,6+mm)
        hold on
        [t,h,ws] = settling(0);
        if h(1) > 30
            p1(nn) = plot(t,h-30, 'Color', cols(nn,:));
        else
            p1(nn) = plot(t,h, 'Color', cols(nn,:));
        end
        if mm>1
            [t,h,ws] = settling(1);
            if h(1) > 30
                p2(nn) = plot(t,h-30,'--', 'Color', cols(nn,:));
            else
                p2(nn) = plot(t,h,'--', 'Color', cols(nn,:));
            end
        end
        if nn == length(dirs{mm})
            if (mm == length(dirs)) && strcmp(gamm,'gamm0.3')
                leg = legend(p1,{'$D_p/\Delta x=15$','$D_p/\Delta x=25$','$D_p/\Delta x=40$'});
                leg.Location = 'South';
            elseif (mm == 2) && strcmp(gamm,'gamm0.9')
                leg = legend(p1,{'$D_p/\Delta x=15$','$D_p/\Delta x=20$','$D_p/\Delta x=30$'});
            elseif (mm == 4) && strcmp(gamm,'gamm0.9')
                leg = legend(p1,{'$D_p/\Delta x=25$'});
            elseif (mm > 2) && strcmp(gamm,'gamm1.0')
                leg = legend(p1,{'$D_p/\Delta x=25$'});
            elseif (mm == 5) && strcmp(gamm,'gamm0.1')
                leg = legend(p1,{'$D_p/\Delta x=15$'});
            else
                legend(p1,{'$D_p/\Delta x=15$','$D_p/\Delta x=25$'})
            end
        end
        %xlabel('$t/\tau$')
        if mm == 1
            ylabel('$y_p/D_p$')
        end

        if mm > 1
            subplot(5,6,12+mm)
            hold on
            [t,s,vs] = particle_separation();
            plot(t,s-1);
            if mm == 2
                ylabel('$s/D_p$')
            end
        end

        if mm > 1
            subplot(5,6,18+mm)
            hold on
            [t, th] = particle_angle();
            plot(t,abs(th))
            if mm == 2
                ylabel('$\theta$')
            end
        end

        subplot(5,6,24+mm)
        hold on
        doplot = true;
        try
            load('entrained_tracer')
            mass = volume * 6/pi;% * (1-gam) * (1-1/rho_s);
        catch
            try
                load('entrained_mass')
                mass = M_entrain * 6/pi;% * (1-gam) * (1-1/rho_s);
            catch
                doplot = false;
            end
        end
        if doplot
            plot(time, mass);
        end
        if (mm == 1) && (nn==1)
            ylabel('$C_{entrain}$')
        end

    end
end

figure_defaults()
cd('../figures')
print_figure(fname,'format','pdf','res',700,'size',[15 12])
