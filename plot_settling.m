function [time, y_p, vel] = plot_settling(particle_ID)
% plot the settling of a single particle

if nargin == 0
    particle_ID = 0;
end

% check the version of the simulation
if exist('mobile.dat','file') == 2
    % old cases (1 particle) where the particle ID was not in the file name
    old_version = true;
    file_name = 'mobile';
elseif exist('mobile_0.dat','file') == 2
    % new cases where the particle ID IS in the file name
    old_version = false;
    file_name = sprintf('mobile_%d',particle_ID);
else
    error('mobile particles file not found.')
end

% Read data
if exist([file_name,'.mat'], 'file') == 2
    % load cleaned data, if it exists
    diag_file = [file_name,'.mat'];
    particle_data = load(diag_file);
    % also load the txt file to check if mat file is up to date
    diag_dat = readtable([file_name,'.dat']);
else
    % otherwise read raw data (this will likely be fine, unless a restart caused overlapping data)
    diag_file = [file_name,'.dat'];
    particle_data = readtable(diag_file);
end

% get data
if old_version
    time = particle_data.Var1;
    y_p  = particle_data.Var4;
else
    time = particle_data.time;
    y_p  = particle_data.y;
end

% calculate velocity
Dmat = FiniteDiff(time, 1, 2, false, false);
vel = Dmat * y_p;


% make figure
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
