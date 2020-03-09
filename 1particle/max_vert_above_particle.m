% compare the maximum vertical velocity above a single settling particle


base = '/project/6001470/ddeepwel/part_settling/1particle/thick_strat/Ri0.5/';
cases = {...%'sigma10/try1',...
         'Re10',...
         'Re5',...
         'Re2.5',...
         'Re1',...
         'Re0.5',...
         'Re0.25'};

Ncases = length(cases);

for nn = 1:Ncases
    cd([base,cases{nn}])
    load('xsection_vert_00')

    max_v(nn) = max(v_ty(:));
end

Re = [10 5 2.5 1 0.5 0.25];

figure(43)
clf
hold on

plot(Re, max_v, 'ok')
xlabel('$Re$')
ylabel('max vert. vel. above particle / $ w_s$')
figure_defaults()

%%% NOTE %%%
% the stokes settling velocity scale is different for each case!!
% this is because the Reynolds number is different between cases (w_s = nu Re / D_p)

cd('../figures')
print_figure('max_suction_vel','format','pdf','size',[6 4])
