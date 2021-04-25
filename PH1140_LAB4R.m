clear
close all
clc

% Inputs
b = 0.2;    % Damping Coefficient(Friction)
g = 9.81;    % Gravity in m/s2
l = 1;     % Length of Pendulum in meter
m = 1;     % Mass of the ball in kilogram

% Initial Condition
theta_0 = [pi/18;3];     % Set displacement and Velocity

% Time Points
t_span = linspace(0,40,4000); % Time array

% Solve ODE with sin(theta)
[t,r] = ode45(@(t,theta) odefunc(t,theta,b,g,l,m),t_span,theta_0);

% Solve ODE with theta
[t,r_2] = ode45(@(t,theta) odefuncTheta(t,theta,b,g,l,m),t_span,theta_0);

% Plotting
figure(1)
plot(t,r(:,1))
hold on
plot(t,r(:,2))
hold on
plot(t,r_2(:,1))
title('Motion of a Simple Damped Pendulum');
ylabel('Plot')
xlabel('Time (second)')
legend('Displacement Based on sin(theta) (radians)','Velocity (rad/sec)','Displacement Based on theta (radians)');
hold off
pause(2)

% Pendulum Animation
ct = 1;   % Loop for animation
for i=1:length(r(:,1))
    x0 = 0;
    y0 = 0;
    x1 = l*sin(r(i,1));
    y1 = -(l*cos(r(i,1)));
    figure(2)
    plot([-1,1],[0,0],'linewidth',3,'color','m');
    hold on 
    plot([x0 x1], [y0 y1],'linewidth',3,'color','b');
    hold off
    hold on
    plot(x1,y1,'o','markersize',20,'markerfacecolor','g','markeredgecolor','b');
    hold off
    title('Simulation of a Damped Pendulum Motion');
    grid on
    axis([-1. 1.5 -1.5 .5]);
    
    M=getframe(gcf);
    ct = ct + 1;
end

movie(M)
video=VideoWriter('Pendulumn.avi','Uncompressed AVI');
open(video)
writeVideo(video,M)
close(video)








