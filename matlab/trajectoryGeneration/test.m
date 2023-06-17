%% test
clc
close
clear

XC=[0;0;0];
YC=[0;0;0];
ZC=[0;0;0];
PO=[0;0;0];

iterations = 300;

for D = 1:iterations
THS=orbitglass([100;15;100],[90;15;100],D,(D*pi*2)/100,60);

XC=[XC,THS(1:3,1)];
YC=[YC,THS(1:3,2)];
ZC=[ZC,THS(1:3,3)];
PO=[PO,THS(1:3,4)];
end

plot3(PO(1,:),PO(2,:),PO(3,:))

hold on
plot3(200,200,200)
for H = 1:iterations+1

Sv=PO(:,H);

Xv=(XC(:,H)*10+PO(:,H));
Yv=(YC(:,H)*10+PO(:,H));
Zv=(ZC(:,H)*10+PO(:,H));

plot3([Xv(1),Sv(1)],[Xv(2),Sv(2)],[Xv(3),Sv(3)],"Color",[1,0,0])
plot3([Yv(1),Sv(1)],[Yv(2),Sv(2)],[Yv(3),Sv(3)],"Color",[0,1,0])
plot3([Zv(1),Sv(1)],[Zv(2),Sv(2)],[Zv(3),Sv(3)],"Color",[0,0,1])

end
drawnow
%%
function T = orbitglass(pos1,pos2,centercord,rotation,radius)

dir1= pos2-pos1;
dir1=dir1/norm(dir1);
%dir1 = x1
centerlinecord=dir1*centercord+pos1;

dir11=([1;1;1]-dir1);
dir11=dir11/norm(dir11);

disp(dir1);
disp(dir11);

dir2=cross(dir1,dir11);
dir2=dir2/norm(dir2);
%dir2=z1

dir3=(cross(dir1,dir2));
dir3=-1*dir3/norm(dir3);
%dir3=y1

disp(dir2);
disp(dir3);

distre=dir3*c(rotation)+dir2*sin(rotation)/norm(dir3*c(rotation)+dir2*sin(rotation));
perimiter=centerlinecord+distre*radius;

Z=(centerlinecord-perimiter);
disp("glass point")
Z=Z/norm(Z);
Y=(cross(Z,dir1));
Y=Y/norm(Y)*-1;
X=(cross(Z,Y));
X=X/norm(X)*-1;
disp(X)
disp(Y)
disp(Z)
T=[X,Y,Z,perimiter;0,0,0,1];
disp(T);

end

function ret = c(x)
    ret = cos(x);
end