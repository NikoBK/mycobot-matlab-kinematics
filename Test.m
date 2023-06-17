
anglez = 150 * pi/180;
anglex = 90 * pi/180;

rotz = [
    cos(anglez), -sin(anglez), 0;
    sin(anglez), cos(anglez), 0;
    0,0,1
]

rotx = [
    1,0,0;
    0,cos(anglex), -sin(anglex);
    0,sin(anglex), cos(anglex)
]

rotf = rotz * rotx