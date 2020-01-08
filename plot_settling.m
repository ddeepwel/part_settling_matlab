function [time, y_p, vel] = plot_settling()
% plot the settling of a single particle

file_name = 'mobile';
if exist([file_name,'.mat'], 'file') == 2
    % load cleaned data, if it exists
    diag_file = [file_name,'.mat'];
    particle_data = load(diag_file);
    % also load the txt file to check if mat file is up to date
    diag_dat = readtable([file_name,'.dat']);
elseif exist([file_name,'.dat'], 'file') == 2
    % otherwise read raw data (this will likely be fine, unless a restart caused overlapping data)
    diag_file = [file_name,'.dat'];
    particle_data = readtable(diag_file);
else
    error('mobile particles file not found.')
end


time = particle_data.Var1;
y_p  = particle_data.Var4;

Dmat = FiniteDiff(time, 1, 2, false, false);
vel = Dmat * y_p;

figure(65)
%clf
subplot(2,1,1)
hold on
plot(time, y_p)
fprintf('Initial particle position: %g D_p\n',y_p(1))
ylabel('$s_p/D_p$')
title('particle position and velocity')

subplot(2,1,2)
hold on
plot(time, vel)
ylabel('$w_p/w_s$')
xlabel('$t$')

figure_defaults()
