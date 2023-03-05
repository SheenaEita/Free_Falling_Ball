%% Generate model of free falling ball
clc;
clear;
close all;

m = 1; %mass [kg]
g = 9.81; %gravity [m/s^2]
h = 10; %high, [m]
save('param.mat', "h","g","m");

%% System coordinates
y = sym('y', [2, 1], 'real'); % y = [position; velocity]
q = y(1); q_dot = y(2);

%% Lagrangian
T = m*(q_dot'*q_dot)/2;
V = m*g*q;
L = T - V;

euler_lagrangian_eqn = [q_dot; jacobian(L, q)' - jacobian(jacobian(L, q_dot), q)*q_dot];

%% Generate ODE and event function by using matlabFunction
syms t real
matlabFunction(simplify(euler_lagrangian_eqn), 'file', 'FFB_function',...
    'vars', {t, y});
matlabFunction(y(1), 1, -1, 'file', 'Event_TD', 'vars', {t, y},...
    'outputs', {'value', 'isterminal', 'direction'});

disp('Done.');