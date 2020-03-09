% compare the settling speeds for multiple cases


base = '/project/6001470/ddeepwel/part_settling/comparisons_and_checks/abaid/';
cases = {'fig9_1.045',...
         'fig9_1.045_cfl0.1',...
         'fig9_1.045_dblPe',...
         'fig9_1.045_diffLAG',...
         'fig9_1.045_hires',...
         'fig9_1.045_IBM_SCALAR'};
cases = {'fig9_1.045_halfRi',...
         'fig9_1.045_halfRi_tall',...
         'fig9_1.045_halfRi_tall_hires'};

Ncases = length(cases);


figure(65)
clf
for nn = 1:Ncases
    cd([base,cases{nn}])
    plot_settling
end

subplot(2,1,1)
legend(strrep(cases,'_',' '))

figure_defaults();
%cd('../figures')
%print_figure('settling','format','pdf','size',[6 4])
%cd('..')
