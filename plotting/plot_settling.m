function [] = plot_settling(particle_ID)
% plot the settling of a single particle

if nargin == 0
    particle_ID = 0;
end

params = read_params();
y_pyc = params.pyc_location;

[time, y_p, vel] = settling(particle_ID);

% make figure
figure(65)
%clf
subplot(2,1,1)
hold on
plot(time, y_p,'-')
plot([0 time(end)], [1 1]*y_pyc,'k--')
fprintf('Initial particle position: %g D_p\n',y_p(1))
ylabel('$h_p/D_p$')
title('particle height')
grid on

subplot(2,1,2)
hold on
plot(time, vel,'-')
ylabel('$w_p/w_s$')
xlabel('$t/\tau$')
title('particle velocity')
grid on

figure_defaults()
