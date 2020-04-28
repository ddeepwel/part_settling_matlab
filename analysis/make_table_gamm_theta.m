% make a table of minimum separation distance

base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';

gamms = {...
    'gamm0.9',...
    'gamm0.7',...
    'gamm0.5',...
    ...%'gamm0.3',...
    'gamm0.1',...
    };
gamm = [0.9 0.7 0.5 0.1];

thetas = {...
    's2_th0',...
    's2_th22.5',...
    's2_th45',...
    's2_th67.5',...
    's2_th90',...
    };
theta = [0 22.5 45 67.5 90];

Ngamms = length(gamms);
Ntheta = length(theta);

style = 'entrain_mass';

switch style
    case 'sep'
        min_sep = zeros(Ngamms,Ntheta) * NaN;
    case 'settling'
        min_settling = zeros(Ngamms,Ntheta) * NaN;
    case 'entrain'
        max_entrain = zeros(Ngamms,Ntheta) * NaN;
    case 'entrain_mass'
        entrain_final = zeros(Ngamms,Ntheta) * NaN;
end
near_bottom = zeros(Ngamms,Ntheta) * NaN;
need_longer = zeros(Ngamms,Ntheta) * NaN;

for mm = 1:Ngamms
    for nn = 1:Ntheta
        cd([base,gamms{mm},'/',thetas{nn}])
        %if mm == 2 && nn == 1
        %    cd('../s2_th0_cfl0.25')
        %elseif mm == 2 && nn == 3
        %    cd('../s2_th45_cfl0.25')
        %elseif mm == 2 && nn == 5
        %    cd('../s2_th90_cfl0.25')
        %end
        switch style
            case 'sep'
                [min_sep_val, val_time] = min_part_sep();
                min_sep(mm,nn) = min_sep_val;
            case 'settling'
                [min_settling_val, val_time] = min_settling_speed();
                min_settling_vel(mm,nn) = min_settling_val;
            case 'entrain'
                [max_entrain_val, val_time] = max_entrain_vol();
                max_entrain(mm,nn) = max_entrain_val;
            case 'entrain_mass'
                [val, val_time] = get_entrain_mass_final();
                entrain_final(mm,nn) = val(end);
        end

        % check if minimum distance was near end of simulation
        % this could be because the simulation hasn't gone far enough
        % or that the particles reached the bottom (need deeper tank)
        switch style
            case 'entrain_mass'
                if abs(diff(val)) / val(end) > 0.05
                    need_longer(mm,nn) = 1;
                end
            otherwise
                ts = settling(0);
                tf = ts(end);
                if tf - val_time < 10
                    near_bottom(mm,nn) = 1;
                end
        end
    end
    completion(mm,Ngamms)
end

cd('../../compare_data')
s0 = 2;
switch style
    case 'sep'
        fname = 'min_sep_s2';
        save(fname,'min_sep','gamm','theta','s0','near_bottom')
    case 'settling'
        fname = 'min_settling_s2';
        save(fname,'min_settling_vel','gamm','theta','s0','near_bottom')
    case 'entrain'
        fname = 'max_entrain_s2';
        save(fname,'max_entrain','gamm','theta','s0','near_bottom')
    case 'entrain_mass'
        fname = 'entrain_final_s2';
        save(fname,'entrain_final','gamm','theta','s0','need_longer')
end
