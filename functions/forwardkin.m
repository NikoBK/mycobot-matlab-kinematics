function [P, O] = FK(q)
    
    o1 = q(1); o2 = q(2); o3 = q(3); 
    o4 = q(4); o5 = q(5); o6 = q(6);

    X = cos(o1)*(-135*sin(o2)-120*sin(o2+o3) + 65.5*sin(o5)*cos(o2+o3+o4) -95*sin(o2+o3+o4) ) + sin(o1)*(88.7800 +65.5*cos(o5)); 
    Y = sin(o1)*(-135*sin(o2)-120*sin(o2+o3) + 65.5*sin(o5)*cos(o2+o3+o4) -95*sin(o2+o3+o4) ) - cos(o1)*(88.7800 +65.5*cos(o5));
    Z = 95*cos(o2 + o3 + o4) + 120*cos(o2 + o3) + 135*cos(o2) + 65.5*sin(o2 + o3 +o4)*sin(o5) + 173.9;
    
    R11 = cos(o6)*(sin(o1)*sin(o5)  - cos(o1)*cos(o5)*cos(o2+o3+o4)) + sin(o2+o3+o4)*cos(o1)*sin(o6);
    R12 = sin(o2 + o3 + o4)*cos(o1)*cos(o6) - sin(o6)*(sin(o1)*sin(o5) - cos(o1)*cos(o5)*cos(o2+o3+o4));
    R13 = sin(o1)*cos(o5) + cos(o1)*sin(o5)*cos(o2+o3+o4);    
    R23 = sin(o1)*sin(o5)* cos(o2+o3+o4) - cos(o1)*cos(o5);
    R33 = sin(o2+o3+o4)*sin(o5); 

    theta_x = atan2(-R23, R33);
    theta_y = atan2(R13, (R11^2+R12^2)^0.5);
    theta_z = atan2(-R12, R11);
    
    P = [X,Y,Z];
    O = [theta_x, theta_y, theta_z];
end