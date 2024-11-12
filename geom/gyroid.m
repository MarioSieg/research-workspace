clc
clear
close all

SizeL = 20;
Def = 40;

SFact = (SizeL/2)/pi;

A = SFact*pi;
D = A/Def;

[X,Y,Z] = meshgrid(-A:D:A);

    OBJ = cos(X/SFact).*sin(Y/SFact) + cos(Y/SFact).*sin(Z/SFact) + cos(Z/SFact).*sin(X/SFact);
    T = 0.5;
    OBJ = (OBJ - T) .* (OBJ + T);

    [F1,V1] = isosurface(X,Y,Z,OBJ,0);
    [F2,V2] = isocaps(X,Y,Z,OBJ,0,'below');

    F3 = [F1; F2+length(V1(:,1))];
    V3 = [V1;V2];

    p = patch('Vertices',V3,'Faces', F3, 'FaceColor', 'red', 'EdgeColor', 'none');
    view(3);
    camlight