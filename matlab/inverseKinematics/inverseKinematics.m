% Name:     inverseKinematics.m
% Created:  5/22/2023
% Author:   264

close all; clear; clc;

% While the geometrical/analytical way of doing inverse kinematics is good
% because it finds all possible solutions, the numerical systematically
% finds as many solutions as possible, doing what can be described as
% bruteforcing it's way to the solutions.

% Error arrays to evaluate how well the found solution has been found.
error = []; % General Error.
p_error = []; % Position Error.
o_error = []; % Orientation Error.
q_error = {};

% Plot errors on graphs
plotErrors = false;

% The theta values we want to find through inverse kinematics.
% these values are used in forward kinematics (see the next line of code)
% to generate the end frame we will apply to the inverse kinematics.
thetas = [10, 20, 30, 40, 50, 60];

% Get the end frame position and orientation.
[P, O] = getFinalFrame(thetas);
goalPosition = P;
goalOrientation = O;

% Options for the optimization algorithm.
% Currently set to run 6000 times (1000 times per variable), default: 200.
options = optimset('MaxFunEvals', 6 * 60000);

i = 0;
for n = 0:1000

    % The numeric solutions need a good starting guess. This serves as a
    % seed rather than something like 0, 0, ..., 0, we get random numbers
    % for each entry in q0 which is a vector.
    q0 = [0, 0, 0, 0, 0, 0] + (rand(1,6) * 2 - 1) * 20 * pi/180;

    % Solve the inverse kinematics.
    % fminsearch works similar to 'fminunc' however this one is a better
    % choice, than that and the other option 'fmincon' which takes
    % conditions.
    [q, error_n] = fminsearch(@(q) solveFunction(q, goalPosition, goalOrientation), q0, options);

    % Check results.
    [posFinal, oriFinal] = getFinalFrame(q);

    i = i + 1;
    p_error(i,:) = (posFinal - goalPosition).^2;
    o_error(i,:) = angdiff(oriFinal, goalOrientation).^2;
    q_error{i} = q;
    error(i) = error_n;
end

% Plot the results after exiting the loop iterations.
if plotErrors
    plot(p_error)
    figure()
    plot(o_error)
    figure()
    plot(error)
end

% Minimize all errors to find the smallest error in the error array.
[M, I] = min(error);
q_min = q_error{i}
q_minDeg = q_min * 180/pi
[Pos_min, Ori_min] = getFinalFrame(q_min)
error(I);

% Log the goal position to verify
goalPosition
goalOrientation




























% End of document :)