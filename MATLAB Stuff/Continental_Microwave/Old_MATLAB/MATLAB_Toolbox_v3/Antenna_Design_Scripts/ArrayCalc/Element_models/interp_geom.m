function geom=interp_geom()
% Geometry definition for interpolated element data
%
% Usage: geom=interp_geom()


%Coords           X   Y   Z
geom(1:3,1)=[ -0.25 ; 0  ;0  ]; % One end of dipole
geom(1:3,2)=[ 0.25  ; 0  ;0  ]; % the other end




% Geometry above is for example file ex3, a dipole.
% Change as appropriate for your element.
%
% Tip :
% To draw separate lines e.g. for a yagi just insert a NaN
% in the coordinate list, between line segments.
%
% e.g.
%                X     Y     Z
% geom(1:3,1)=[ -1.0 ; 0   ; 0   ]; % Beginning of 1st line
% geom(1:3,2)=[ +1.0 ; 0   ; 0   ]; % End of 1st line
% geom(1:3,3)=[  NaN ; NaN ; NaN ]; % Break
% geom(1:3,4)=[ -0.7 ; 0.5 ; 0   ]; % Beginning of 2nd line
% geom(1:3,5)=[ +0.7 ; 0.5 ; 0   ]; % End of 2nd line



