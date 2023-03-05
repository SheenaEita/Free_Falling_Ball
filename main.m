clc;
clear;
close all;

load param.mat;
tspan = [0 10];
initial_cond = [h, 0]; %initial condition, [position velocity]

%tolerances for ode45
reltol = 10^(-7);
abstol = 10^(-7);

ode_option = odeset('Events',@Event_TD,"RelTol",reltol,"AbsTol",abstol);

%% Using ode45 to solve the analytical solution
[t, y] = ode45(@FFB_function, tspan, initial_cond, ode_option);

plot(t, y(:, 1));
hold on;
plot(t, y(:, 2));
xlabel('time [s]');
ylabel('position [m] and velocity [m/s]');
legend('ball position', 'ball velocity');