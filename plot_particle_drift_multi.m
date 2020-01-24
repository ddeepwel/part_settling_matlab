% plot particle drift

% base directory, and which cases
base = '/project/6001470/ddeepwel/part_settling/2particles/no_strat/Re0.25/';

%cases = {'D2_th0','D2_th22.5','D2_th45','D2_th90'};
cases = {'D4_th0','D4_th45','D4_th90'};
%cases = {'D2_th22.5','../../rho_s2_old/Re0.25/D2_th22.5'};
%cases = {'D2_th22.5','D2_th22.5_old'};

if nargin == 0
    p1 = 0;
    p2 = 1;
end

figure(70)
clf
for mm = 1:length(cases)
    try
        cd([base,cases{mm}])
    catch
        cd(cases{mm})
    end

    plot_particle_drift(p1,p2,false,true);
end

% adjust legend label
leg_lab = strrep(cases,'_',' ');
leg = legend(leg_lab);
leg.Location = 'best';

% check for each case!
%ylim([-0.04 0.04])

% save figure
check_make_dir('../figures')
cd('../figures')
print_figure('particle_drift_D4','format','pdf','size',[6 4])
cd('..')
