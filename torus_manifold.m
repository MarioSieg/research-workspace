R = 3;
r = 1;

theta = linspace(0, 2*pi, 100);
phi = linspace(0, 2*pi, 100);
[Theta, Phi] = meshgrid(theta, phi);

X = (R + r * cos(Phi)) .* cos(Theta);
Y = (R + r * cos(Phi)) .* sin(Theta);
Z = r * sin(Phi);

figure;
surf(X, Y, Z);
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Torus');
colormap('jet');
shading interp;

