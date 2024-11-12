% 4-Dimensional Object: The Tesseract
% Matlab script
%
% Copyright 2009 Ian E., Adam H., Mark Ross <krazkidd@gmail.com>
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% Clear graph
clf;

%%%%%%%%%%%%%%%%% Set up the tesseract %%%%%%%%%%%%%%%%%%%

% Define matrix for vertices - each row in the verts4d matrix defines
% the location of a vertex
verts4d = [-1 -1 -1 -1; 
            1 -1 -1 -1; % patch() requires row vectors
           -1  1 -1 -1;
           -1 -1  1 -1;
            1  1 -1 -1;
            1 -1  1 -1;
           -1  1  1 -1;
            1  1  1 -1;
           
           -1 -1 -1  1; 
            1 -1 -1  1; 
           -1  1 -1  1;
           -1 -1  1  1;
            1  1 -1  1;
            1 -1  1  1;
           -1  1  1  1;
            1  1  1  1];    
       
% Define matrix for faces - each row in the faces matrix defines a
% face/polygon *using* the vertices in the verts4d matrix. This is 
% for the patch() function. 
faces = [ 4  6  8  7;
          1  2  5  3;
          2  6  8  5; % "front cube"
          1  4  7  3;
          1  2  6  4;
          3  5  8  7;
          
         12 14 16 15;
          9 10 13 11;
          9 12 15 11; % "back cube"
         10 14 16 13;
          9 10 14 12;
         11 13 16 15;
    
          4  6  8  7; 
         12 14 16 15; 
          7  8 16 15;
          4  6 14 12;
          4  7 15 12;
          6  8 16 14;
          
          1  2  5  3;
          9 10 13 11;
          1  2 10  9;
          3  5 13 11;
          1  3 11  9;
          2  5 13 10;
          
          1  3  7  4;
          9 11 15 12;
          1  3 11  9;
          4  7 15 12;
          3  7 15 11;
          1  4 12  9;
          
          2  5  8  6;
         10 13 16 14;
          5  8 16 13;
          2  6 14 10;
          6  8 16 14;
          2  5 13 10;
          
          1  4  6  2; 
          9 12 14 10;
          1  4 12  9;
          2  6 14 10;
          6  4 12 14;
          2  1  9 10;
         
          3  7  8  5;
         11 15 16 13;
          3  7 15 11;
          5  8 16 13;
          5  3 11 13;
          8  7 15 16];
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Projection matrix - you can project the tesseract in many different ways.
% These matrices will do an orthogonal (possibly oblique?) 
% projection from 4D space to 3D space.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mProj4to3 = [1 0 0 1;
             0 1 0 0;  % simple projection
             0 0 1 1];
         
% mProj4to3 = [ 1 0 -1 1;
%              .5 1 .5 1; % "hexagon" projection
%               0 0  0 1];
         
% mProj4to3 = [1 0 0 1;
%             0 1 0 1;   % 2D/flat projection (row of 0s or dependent rows)
%             0 0 0 0];     

%mProj4to3 = [1 1 1 1;
%             0 0 0 0;   % 1D/line projection
%             0 0 0 0];

% Do an initial projection
vertsTemp = mProj4to3 * verts4d';

% Make the faces/polygons
p = patch('Faces', faces, 'Vertices', vertsTemp', 'FaceColor','w');

%%%%%%%%%%%%%%%%%%% Set up the graph %%%%%%%%%%%%%%%%%%%%%

% Label the axes of the graph
xlabel('x');
ylabel('y');
zlabel('z');

% Manually set the bounds of the graph 
axis([-5 5 -5 5 -5 5]);

% Set the different "cubes" of the hypercube to different colors
clear cdata;
set(gca,'CLim',[0 80]);
%cdata = [0 0 0 0 0 0  80 80 80 80 80 80  10 10 10 10 10 10  20 20 20 20 20 20  30 30 30 30 30 30  40 40 40 40 40 40  50 50 50 50 50 50  60 60 60 60 60 60];
%cdata = [40 40 40 40 40 40  40 40 40 40 40 40  10 10 10 10 10 10  40 40 40 40 40 40  40 40 40 40 40 40  40 40 40 40 40 40  40 40 40 40 40 40  40 40 40 40 40 40];
cdata = [40 40 40 40 40 40  40 40 40 40 40 40   40 40 40 40 40 40  40 40 40 40 40 40  40 40 40 40 40 40  40 40 40 40 40 40  40 40 40 40 40 40  40 40 40 40 40 40];
set(p,'FaceColor','flat','CData',cdata);

% Set camera position and target manually
%campos([7, -7, 3]);
%camtarget([0, 0, 0.5]);
%camva('manual');
%camzoom(.2);

daspect([1 1 1]); % maintains aspect ratio of axes 

% Set transparency of cube
alpha(p, 0.1);

% Initialize rotation parameter
t = 0;

%%%%%%%%%%%%%%%%%%% Rotate cube %%%%%%%%%%%%%%%%%%%%
% PRESS CTRL-C TO STOP

while true
   % increase parameter t. when it exceeds 2 * pi, revert it to 0 to
   % prevent overflow
   t = t + pi / 120;
   if t >= 2 * pi
       t = 0;
   end
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Rotation matrix - uncomment the matrix which you wish to use to rotate
   % the tesseract; make sure you comment out all the others. It is
   % possible to use two rotations if you make sure not to select a
   % dimension more than once (i.e. don't let both rotations have an 'X' in
   % them - so you can do an XY rotation and ZW rotation). You will have to
   % change the name of the second matrix and put it in the equation below.
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
  rotateMatrix = [ cos(t)  sin(t)  0  0;
                  -sin(t)  cos(t)  0  0; % XY rotation
                     0         0       1  0;
                     0         0       0  1];

   rotateMatrix2 = [1  0    0        0;
                   0  1    0        0;    % ZW rotation
                   0  0  cos(t)  -sin(t);
                   0  0  sin(t)   cos(t)];           
               
%    rotateMatrix = [cos(t)  0  -sin(t)  0;
%                      0     1     0     0; % XZ rotation
%                    sin(t)  0   cos(t)  0;
%                      0     0     0     1];
                 
%    rotateMatrix = [1    0     0     0;
%                    0  cos(t)  0  -sin(t); % YW rotation
%                    0    0     1     0;
%                    0  sin(t)  0   cos(t)];
                    
%    rotateMatrix = [1     0       0     0;
%                    0   cos(t)  sin(t)  0; % YZ rotation
%                    0  -sin(t)  cos(t)  0;
%                    0     0       0     1];
                
%    rotateMatrix = [ cos(t)  0  0  sin(t);
%                       0     1  0    0;    % XW rotation
%                       0     0  1    0;
%                    -sin(t)  0  0  cos(t)];       
   
   % Rotate and project the hypercube - put the second rotation in here if
   % needed
   temp = mProj4to3 * rotateMatrix * rotateMatrix2 *  verts4d';
  
   % Update the vertices with the rotated vectors
   set(p, 'Vertices', temp');
     
   % Redraw
   refreshdata;
   drawnow;
end