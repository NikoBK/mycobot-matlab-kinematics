% Name:     inverseKinematics.m
% Created:  5/22/2023
% Author:   264

% Takes a guess value as parameter, generates forward kinematics, evaluates
% and sum up error. It is important to notice whether or not the errors are
% positive or not. If they are negative something is wrong.
% A new q value will be handled until error is as low as possible.
function error = solveFunction(q, P_goal, O_goal)
    [P, O] = getFinalFrame(q);
    O_rad = O * pi/180;
    Pos_error = P_goal - P;
    Ori_error = angdiff(O_goal, O_rad) * 180/pi;
    
    error = sum(Pos_error.^2) + sum(Ori_error.^2);
end