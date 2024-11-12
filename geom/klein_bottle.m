clf
clear
clc
[x, y, z] = klein();
h = surf(x, y, z);
axis equal
axis off
shading interp
alpha(.5)
xlabel('x value')
ylabel('y value')
zlabel('z value')
disp('Klein Bottle')
