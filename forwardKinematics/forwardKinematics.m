% Name:     forwardKinematics.m
% Created:  5/21/2023
% Author:   264

close all; clear; clc;
sympref('FloatingPointOutput',true);

% A empty 6 dimensional vector to simplify the forward kinematics algebra
% for the theta values that the 'o' vector represents.
o = sym('o', [1,6]);
p = sym(pi); % Symbolic pi

% [DERECATED]
% Get the Denavit Hartenberg parameters.
% dhParams = getDHParams();

% Setup the individual DH matrices.
% This block of code will automatically fetch updated DH parameters when
% they are changed in 'getDHParams.m'.
dhT1 = modifyDHParams(0, 0, 173.9, o(1)); %dhParams(1,1), dhParams(1,2), dhParams(1,3), o(1));
dhT2 = modifyDHParams(p/2, 0, 0, o(2) + p/2); %dhParams(2,1), dhParams(2,2), dhParams(2,3), o(2));
dhT3 = modifyDHParams(0, 135, 0, o(3)); %dhParams(1,1), dhParams(3,2), dhParams(3,3), o(3));
dhT4 = modifyDHParams(0, 120, 88.78, o(4) + p/2); %dhParams(1,1), dhParams(4,2), dhParams(4,3), o(4));
dhT5 = modifyDHParams(p/2, 0, 95, o(5)); %dhParams(1,1), dhParams(5,2), dhParams(5,3), o(5));
dhT6 = modifyDHParams(-p/2, 0, 65.5, o(6)); %dhParams(1,1), dhParams(6,2), dhParams(6,3), o(6));

% The DH matrix for frame 1 to 6.
% NOTE: This only works when the symbolic 'o' vector takes theta's place in
% the modified DH matrices above.
dhT16 = simplify(dhT1 * dhT2 * dhT3 * dhT4 * dhT5 * dhT6);

% Use the theta values to calculate the algebraic position and orientation.
% converted to radians
thetas = [10,20,30,40,50,60] * pi/180;

x = dhT16(1,4)

% Calculate the algebraic equations for forward kinematics to get the final
% frame's xyz and RPY.
[P, O] = getFinalFrame(thetas);
