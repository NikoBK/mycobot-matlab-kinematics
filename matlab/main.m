% Name:     main.m
% Created:  5/17/2023
% Author:   264
%
% Naming Convention: 
%       https://www.ee.columbia.edu/~marios/matlab/MatlabStyle1p5.pdf

% Clear console & cache
close all; clear; clc;

% Convert from metres to milli-metres.
mm = 1e-3;

% Denavit Hartenberg parameters.
% NOTE: Alpha and a are for some reason changed from regular order.
dhParams = [

%      alpha        a           d          theta     %
        0,          0,      173.9 * mm,     0;
        0,         pi/2,         0,         0;
     135 * mm,      0,           0,         0;
     120 * mm,      0,      88.78 * mm,     0;
        0,         pi/2,       95 * mm,     0;
        0,        -pi/2,     65.5 * mm,     0;

];

% Import the robot
mc = importrobot("models/mycobot.urdf");
show(mc);

q1 =  [-0.1548, -42.8000, -21.7888, 4.0513, 123.7374, -63.0000];
q2 = [-0.1548, -42.8000, -17.9758, -4.0513, 128.0272, -63.0000];
q3 = [-44.5592, -42.8000, -5.0116, 68.9094, -137.8978, 63.0000];
q4 = [-44.5592, -42.8000, 59.2755, -68.9094, -64.3661, 63.0000];
q5 = [-53.2465, -48.7962, -10.1661, 75.5623, -136.5901, 64.7954];
q6 = [-53.2465, -48.7962, 60.1748, -75.5623, -55.8064, 64.7954];
qTest = [10, 20, 30, 40, 50, 60];
q = qTest;

cfg = homeConfiguration(mc);

% for i = 1: length(q)
%     cfg(i).JointPosition = cfg(i).JointPosition + q;
% end

%show(mc, cfg)
T = getTransform(mc, cfg, 'link6');

cobot = rigidBodyTree;

body1 = rigidBody('link1');
jnt1 = rigidBodyJoint('joint2_to_joint1','revolute');
body2 = rigidBody('link2');
jnt2 = rigidBodyJoint('joint3_to_joint2','revolute');
body3 = rigidBody('link3');
jnt3 = rigidBodyJoint('joint4_to_joint2','revolute');
body4 = rigidBody('link4');
jnt4 = rigidBodyJoint('joint5_to_joint3','revolute');
body5 = rigidBody('link5');
jnt5 = rigidBodyJoint('joint6_to_joint4','revolute');
body6 = rigidBody('link6');
jnt6 = rigidBodyJoint('joint6output_to_joint6','revolute');

setFixedTransform(jnt1, dhParams(1,:), 'mdh');
setFixedTransform(jnt2, dhParams(2,:), 'mdh');
setFixedTransform(jnt3, dhParams(3,:), 'mdh');
setFixedTransform(jnt4, dhParams(4,:), 'mdh');
setFixedTransform(jnt5, dhParams(5,:), 'mdh');
setFixedTransform(jnt6, dhParams(6,:), 'mdh');

jnt1.HomePosition = 0;
body1.Joint = jnt1;
addBody(cobot, body1, 'base')

jnt2.HomePosition = pi/2;
body2.Joint = jnt2;
addBody(cobot, body2, 'link1')

jnt3.HomePosition = 0;
body3.Joint = jnt3;
addBody(cobot, body3, 'link2')

jnt4.HomePosition = 0;
body4.Joint = jnt4;
addBody(cobot, body4, 'link3')

jnt5.HomePosition = 0;
body5.Joint = jnt5;
addBody(cobot, body5, 'link4')

jnt6.HomePosition = 0;
body6.Joint = jnt6;
addBody(cobot, body6, 'link5')

% Control the model parameters.
figure
cfg = homeConfiguration(cobot);
for i = 1: length(q)
    cfg(i).JointPosition = cfg(i).JointPosition + q(i);
end

show(cobot, cfg, 'Visuals', 'on')
T_cobot = getTransform(cobot, cfg, 'link6');









































%% End of document