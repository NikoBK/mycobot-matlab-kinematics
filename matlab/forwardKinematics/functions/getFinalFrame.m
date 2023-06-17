% Name:     main.m
% Created:  5/21/2023
% Author:   264

% Returns a matrix of two 3 x 1 vectors.
% P = 3 x 1 vector representing position (XYZ)
% O = 3 x 1 vector representing orientation (RPY)
function [P, O] = getFinalFrame(thetas)

dh_a = [0, 0, 135, 120, 0, 0];
dh_d = [173.9, 0, 0, 88.78, 95, 65.5];

% Simplifying the names a bit for cleaner code.
    d1 = dh_d(1);     
    t1 = thetas(1);
    t2 = thetas(2);
    a3 = dh_a(3);     
    t3 = thetas(3);
    a4 = dh_a(4);     
    d4 = dh_d(4);     
    t4 = thetas(4);
    d5 = dh_d(5);     
    t5 = thetas(5);
    d6 = dh_d(6);     
    t6 = thetas(6);

    % Calculate the endframe position.
    X = d4*sin(t1) - a3*cos(t1)*sin(t2) + d6*cos(t5)*sin(t1) - a4*cos(t1)*cos(t2)*sin(t3) - a4*cos(t1)*cos(t3)*sin(t2) - d5*cos(t1)*cos(t2)*cos(t3)*sin(t4) - d5*cos(t1)*cos(t2)*cos(t4)*sin(t3) - d5*cos(t1)*cos(t3)*cos(t4)*sin(t2) + d5*cos(t1)*sin(t2)*sin(t3)*sin(t4) + d6*cos(t1)*cos(t2)*cos(t3)*cos(t4)*sin(t5) - d6*cos(t1)*cos(t2)*sin(t3)*sin(t4)*sin(t5) - d6*cos(t1)*cos(t3)*sin(t2)*sin(t4)*sin(t5) - d6*cos(t1)*cos(t4)*sin(t2)*sin(t3)*sin(t5);
    Y = 95*sin(t1)*sin(t2)*sin(t3)*sin(t4) - d6*cos(t1)*cos(t5) - a3*sin(t1)*sin(t2) - 120*cos(t2)*sin(t1)*sin(t3) - 120*cos(t3)*sin(t1)*sin(t2) - 95*cos(t2)*cos(t3)*sin(t1)*sin(t4) - 95*cos(t2)*cos(t4)*sin(t1)*sin(t3) - 95*cos(t3)*cos(t4)*sin(t1)*sin(t2) - 88.7800*cos(t1) + d6*cos(t2)*cos(t3)*cos(t4)*sin(t1)*sin(t5) - d6*cos(t2)*sin(t1)*sin(t3)*sin(t4)*sin(t5) - d6*cos(t3)*sin(t1)*sin(t2)*sin(t4)*sin(t5) - d6*cos(t4)*sin(t1)*sin(t2)*sin(t3)*sin(t5);
    Z = 95*cos(t2 + t3 + t4) - d6 / 2*cos(t2 + t3 + t4 + t5) + 120*cos(t2 + t3) + a3*cos(t2) + d6 / 2*cos(t2 + t3 + t4 - t5) + d1;

    R11 = cos(t6)*(sin(t1)*sin(t5) - cos(t1)*cos(t2)*cos(t3)*cos(t4)*cos(t5) + cos(t1)*cos(t2)*cos(t5)*sin(t3)*sin(t4) + cos(t1)*cos(t3)*cos(t5)*sin(t2)*sin(t4) + cos(t1)*cos(t4)*cos(t5)*sin(t2)*sin(t3)) + sin(t2 + t3 + t4)*cos(t1)*sin(t6);
    R21 = cos(t6)*(cos(t2)*cos(t5)*sin(t1)*sin(t3)*sin(t4) - cos(t2)*cos(t3)*cos(t4)*cos(t5)*sin(t1) - cos(t1)*sin(t5) + cos(t3)*cos(t5)*sin(t1)*sin(t2)*sin(t4) + cos(t4)*cos(t5)*sin(t1)*sin(t2)*sin(t3)) + sin(t2 + t3 + t4)*sin(t1)*sin(t6);
    R31 = 0.5000*sin(t2 + t3 + t4 - t6) - 0.5000*sin(t2 + t3 + t4 + t6) - sin(t2 + t3 + t4)*cos(t5)*cos(t6);
    
    R32 = sin(t2 + t3 + t4)*cos(t5)*sin(t6) - 0.5000*cos(t2 + t3 + t4 - t6) - 0.5000*cos(t2 + t3 + t4 + t6);
    R33 = 0.5000*cos(t2 + t3 + t4 - t5) - 0.5000*cos(t2 + t3 + t4 + t5);
    
    theta_x = atan2(-R32, R33);
    theta_y = atan2(R31, (R11^2+R21^2)^0.5);
    theta_z = atan2(-R21, R11);

    theta_x_deg = theta_x * 180/pi;
    theta_y_deg = theta_y * 180/pi;
    theta_z_deg = theta_z * 180/pi;

    P = [X,Y,Z];
    O = [theta_x_deg, theta_y_deg, theta_z_deg];
end