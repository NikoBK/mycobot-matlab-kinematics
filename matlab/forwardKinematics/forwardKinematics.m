% Name:     main.m
% Created:  5/21/2023
% Author:   264

close all; clear; clc;

% Get the Denavit Hartenberg parameters.
dhParams = getDHParams();

% Setup the individual DH matrices.
% This block of code will automatically fetch updated DH parameters when
% they are changed in 'getDHParams.m'.
T1 = modifyDHParams(dhParams(1,1), dhParams(1,2), dhParams(1,3), dhParams(1,4));
T2 = modifyDHParams(dhParams(2,1), dhParams(2,2), dhParams(2,3), dhParams(2,4));
T3 = modifyDHParams(dhParams(1,1), dhParams(3,2), dhParams(3,3), dhParams(3,4));
T4 = modifyDHParams(dhParams(1,1), dhParams(4,2), dhParams(4,3), dhParams(4,4));
T5 = modifyDHParams(dhParams(1,1), dhParams(5,2), dhParams(5,3), dhParams(5,4));
T6 = modifyDHParams(dhParams(1,1), dhParams(6,2), dhParams(6,3), dhParams(6,4));