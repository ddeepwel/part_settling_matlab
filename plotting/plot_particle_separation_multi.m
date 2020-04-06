% plot separation between two particles

% base directory, and which cases
%base = '/project/6001470/ddeepwel/part_settling/2particles/no_strat/Re0.25/';
base = '/project/6001470/ddeepwel/part_settling/2particles/sigma1/rho_s2.0/Ri40/Re0.25/';
base = '/home/ddeepwel/scratch/bsuther/part_settling/2particles/sigma1/rho_s2.0/Ri40/Re0.25/';

%cases = {'D2_th0','D2_th22.5','D2_th45','D2_th90'};
%cases = {'D4_th0','D4_th45','D4_th90'};
%cases = {'D2_th22.5','../../rho_s2_old/Re0.25/D2_th22.5'};
%cases = {'D2_th22.5','D2_th22.5_old'};
cases = {'D2_th90_oldpycloc','D2_th90_highPe'};
cases = {'D2_th90_true_highPe','D2_th90_pyc_7Dp'};

%leg_lab = strrep(cases,'_',' ');
leg_lab = {'$z_p-z_{pyc} = 5 D_p$','$z_p-z_{pyc} = 7 D_p$'};


%if nargin == 0
    p1 = 0;
    p2 = 1;
%end

figure(67)
clf
for mm = 1:length(cases)
    try
        cd([base,cases{mm}])
    catch
        cd(cases{mm})
    end
    fprintf('case: %s\n',cases{mm})

    plot_particle_separation(p1,p2,false,true);
end

% adjust legend label
leg = legend(leg_lab);
leg.Location = 'best';

% change for each case!
%ylim([-0.04 0.04])

figure_defaults()

% save figure
check_make_dir('../figures')
cd('../figures')
print_figure('particle_separation','format','pdf','size',[6 4])
cd('..')
