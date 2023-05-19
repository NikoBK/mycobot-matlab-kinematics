% created by, etc..

%% Setup
% Clear console & cache
close all; clear; clc;

% Import the robot model.
% mc = MyCobot
mc = importrobot("mycobot.urdf");

% A 6 x 1 vector with randomly generated values for theta joints.
% The purpose of this is to always simulate a random position and make sure
% that the DH-based position and orientation is similar to the hardcoded
% config. That being all joints have the same angles defined and as such
% both the hardcoded and dh based FK should achieve the same result.
%
% If they do not achieve the same end effector xyzRPY something is wrong.
random_jnts = rand(6, 1);

% Set the configuration to home config which is just the positions that the
% robot should start on. Afterwards we generate a 3d figure with the
% desired config that is just 0 for this example.
cfg = homeConfiguration(mc);
show(mc, cfg)

%% Forward Kinematics
theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;
theta5 = 0;
theta6 = 0;

% Some notes on this DH parameter notation:
%   - Every d value is assigned '* 1e-3'. This is because the units are
%     originally in metres and we want to work in millimeters.
dhParams = [
%           a             alpha        d         theta
            0,              0,    173.9 * 1e-3,  theta1;
            0,             pi/2,         0,      theta2;
        135 * 1e-3          0            0,      theta3;
        120 * 1e-3          0      88.78 * 1e-3, theta4;
            0,             pi/2,      95 * 1e-3, theta5;
            0,            -pi/2    65.5 * 1e-3,  theta6

];



















































