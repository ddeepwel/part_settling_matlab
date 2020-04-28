% make a table of different values for particile separation and orientation angle
% s, and theta

base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/Re0.25/';

gamm = 'gamm0.9';
ss = [2 4 6];
thetas = [0 22.5 45 67.5 90];

Nss = length(ss);
Nthetas = length(thetas);

style = 'entrain_mass';

switch style
    case 'sep'
        min_sep = zeros(Nss,Nthetas) * NaN;
    case 'settling'
        min_settling_vel = zeros(Nss,Nthetas) * NaN;
    case 'entrain'
        max_entrain = zeros(Nss,Nthetas) * NaN;
    case 'entrain_mass'
        entrain_final = zeros(Nss,Nthetas) * NaN;
end
near_bottom = zeros(Nss,Nthetas) * NaN;

for mm = 1:Nss
    for nn = 1:Nthetas
        %if mm > 1 && (nn == 2 || nn == 4)
        %    continue
        %end
        direc = sprintf('%s/%s/s%d_th%g',base,gamm,ss(mm),thetas(nn));
        cd(direc)
        switch style
            case 'sep'
                [min_sep_val, min_time] = min_part_sep();
                min_sep(mm,nn) = min_sep_val;
            case 'settling'
                [min_settling_val, min_time] = min_settling_speed();
                min_settling_vel(mm,nn) = min_settling_val;
            case 'entrain'
                [max_entrain_val, min_time] = max_entrain_vol();
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
                if tf - min_time < 10
                    near_bottom(mm,nn) = 1;
                end
        end
    end
    completion(mm,Nss)
end

cd('../../compare_data')
s0 = 2;
switch style
    case 'sep'
        fname = ['min_sep_',strrep(gamm,'.','')];
        save(fname,'min_sep','ss','thetas','gamm','near_bottom')
    case 'settling'
        fname = ['min_settling_',strrep(gamm,'.','')];
        save(fname,'min_settling_vel','ss','thetas','gamm','near_bottom')
    case 'entrain'
        fname = ['max_entrain_',strrep(gamm,'.','')];
        save(fname,'max_entrain','ss','thetas','gamm','near_bottom')
    case 'entrain_mass'
        fname = ['entrain_final_',strrep(gamm,'.','')];
        save(fname,'entrain_final','ss','thetas','gamm','need_longer')
end
