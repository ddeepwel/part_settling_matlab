function [time, y_p, vel] = plot_settling(particle_ID)
% plot the settling of a single particle

if nargin == 0
    particle_ID = 0;
end

% Read data
file_name = sprintf('mobile_%d',particle_ID);
particle_data = check_read_dat(file_name);

% get data
time = particle_data.time;
y_p  = particle_data.y;

% calculate velocity
Dmat = FiniteDiff(time, 1, 2, true, false); % some cases have the time step change
vel = Dmat * y_p;


% make figure
figure(65)
%clf
subplot(2,1,1)
hold on
plot(time, y_p,'-')
fprintf('Initial particle position: %g D_p\n',y_p(1))
ylabel('$h_p/D_p$')
title('particle height')
grid on

subplot(2,1,2)
hold on
plot(time, vel,'-')
ylabel('$w_p/w_s$')
xlabel('$t$')
title('particle velocity')
grid on

figure_defaults()
