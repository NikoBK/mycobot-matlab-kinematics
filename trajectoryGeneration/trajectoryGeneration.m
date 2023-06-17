clear; close all; clc;

direction = [1, 0, 0];

startVec = [5; 4; 5];
endVec = [10; 4; 5];
vecProduct = endVec - startVec / norm(endVec - startVec);

length = 20;
tilt = endVec - startVec;
line = vecProduct * length + startVec
x = [185; 4; 5];
y = [0;68;0];
z = [0;0;85];
%perimeter = (sin(t) * direction(1,1) + cos(t) * direction(1,3)) * r;
plot3(vecProduct(1,1), vecProduct(2,1), vecProduct(3,1))