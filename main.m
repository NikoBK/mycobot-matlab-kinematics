% Name:     main.m
% Created:  5/17/2023
% Author:   264

% Clear console & cache
close all; clear; clc;

% Import the robot
mc = importrobot("mycobot.urdf");
show(mc);

%% Configure the robot to a random configuration
%% QUESTION: Why are we doing this?
% Create a vector of randomized values for joint positions.
% Variable q is a vector of size 6 x 1
q = rand(6, 1);
cfg = homeConfiguration(mc);

% Set each individual joint to a entry value of the q vector.
for i = 1: length(q)
    cfg(i).JointPosition = cfg(i).JointPosition + q(i);
end

% Show the randomized config for the robot.
show(mc, cfg)

%% Forward Kinematics
theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;
theta5 = 0;
theta6 = 0;

% Our Denavit Hartenberg parameters.
dhParams = [ 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              0,      0,     0,      theta1;
             -90      0,     0,    theta2 - 90;
              0,     135,    0,       theta3
              90,    120,  88.78,  theta4 + 90;
              90,     0,    05,       theta5;
             -90,     0,     0,       theta6
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         ];

%% Rasmus' DH parametres
dhParams_Test = [   
               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    0,        0,      173.9 * 1e-3,     0;
                    0,       pi/2,        0,            0;
                135 * 1e-3,   0,          0,            0;
                120 * 1e-3,   0,     88.78 * 1e-3,      0;
                    0,       pi/2,     95 * 1e-3,       0;
                    0,      -pi/2,    65.5 * 1e-3,      0
               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            ];

% Setting up the robot rigidbody tree.
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

setFixedTransform(jnt1, dhParams_Test(1,:),'mdh')
setFixedTransform(jnt2, dhParams_Test(2,:),'mdh')
setFixedTransform(jnt3, dhParams_Test(3,:),'mdh')
setFixedTransform(jnt4, dhParams_Test(4,:),'mdh')
setFixedTransform(jnt5, dhParams_Test(5,:),'mdh')
setFixedTransform(jnt6, dhParams_Test(6,:),'mdh')

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

show(cobot, cfg)
T_cobot = getTransform(cobot, cfg, 'link6');
pos = T_cobot(1:3,4) * 1e3;
ori = rotm2eul(T_cobot(1:3,1:3), "XYZ");

% Find the important equations
p = sym(pi);
o = sym('o', [1,6]);

theta_home = [0, p/2, 0, p/2, 0, 0];
T1 = ModDH(0, 0, 179.3, o(1) + theta_home(1));
T2 = ModDH(pi/2, 0, 0, o(2) + theta_home(2));
T3 = ModDH(0, 0, 135, o(3) + theta_home(3));
T4 = ModDH(0, 120, 88.78, o(4) + theta_home(4));
T5 = ModDH(pi/2, 0, 95, o(5) + theta_home(5));
T6 = ModDH(-pi/2, 0, 65.5, o(6) + theta_home(6));

T_sym = simplify(T1 * T2 * T3 * T4 * T5 * T6);
Pos = T_sym(1:3, 4);

% Forward Kinematics Function
[P, O] = FK(q);



























%% End of document