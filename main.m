% Name:     main.m
% Created:  5/17/2023
% Author:   264

% Clear console & cache
close all; clear; clc;

% Import the robot
mc = importrobot("mycobot.urdf");
show(mc);