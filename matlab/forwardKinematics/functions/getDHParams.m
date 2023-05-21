% Name:     main.m
% Created:  5/21/2023
% Author:   264

% Returns the DH parameters as a matrix.
% thetas = a 6 x 1 vector with all theta values
function dhParameters = getDHParams()

% Theta values for all joints
thetas = [
    0; % Joint 1 - Theta 1
    0; % Joint 2 - Theta 2
    0; % Joint 3 - Theta 3
    0; % Joint 4 - Theta 4
    0; % Joint 5 - Theta 5
    0; % Joint 6 - Theta 6
];

dhParameters = [ 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   alpha       a              d               theta
              0,        0,       179.3 * 1e-3,       thetas(1,:);
             pi/2,      0,             0,        thetas(2,:) - pi/2;
              0,    135 * 1e-3,        0,            thetas(3,:);
              0,    120 * 1e-3,   88.78 * 1e-3,  thetas(4,:) + pi/2;
             pi/2,      0,          95 * 1e-3,       thetas(5,:);
            -pi/2,      0,          65 * 1e-3,       thetas(6,:);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         ];
end