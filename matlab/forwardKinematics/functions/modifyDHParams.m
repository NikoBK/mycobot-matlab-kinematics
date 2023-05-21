% Name:     main.m
% Created:  5/21/2023
% Author:   264

% Returns a modified DH matrix that takes DH parameters and parses
% them into a transformation matrix specifically used in a manner that
% makes it a "DH matrix".
function modifiedDHParams = modifyDHParams(alpha, a, d, theta)
    % Tidy up the matrix elements to make
    % it look a little better.
    r11 = cos(theta);
    r12 = -sin(theta);
    r13 = 0;
    r14 = a;
    r21 = sin(theta) * cos(alpha);
    r22 = cos(theta) * cos(alpha);
    r23 = -sin(alpha);
    r24 = -sin(alpha) * d;
    r31 = sin(theta) * sin(alpha);
    r32 = cos(theta) * sin(alpha);
    r33 = cos(alpha);
    r34 = cos(alpha) * d;

    % The 4 x 4 matrix to be returned.
    modifiedDHParams = [
        r11, r12, r13, r14;
        r21, r22, r23, r24;
        r31, r32, r33, r34;
         0    0    0    1
    ];
end