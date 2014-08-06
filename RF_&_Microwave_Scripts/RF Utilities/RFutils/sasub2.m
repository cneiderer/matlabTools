function smsub2(mS,Yo)
% Admittance Chart Subroutine2
% Draws circles on the imaginary axis, radius r at locn (1,r)
%
% Calculates cropping point on smith chart circle
% Then draws arcs for +j and -j
%
% mS....Admittance circle to be drawn
% Yo....Normalising admittance
%
% Called by sadmit.m

% N.Tucker www.activefrance.com 2008

% Find (x,y) point on chart corresponding to +j*(ohms)

mS=mS*j;                % convert ohms to imaginary value
p=(mS-Yo)/(mS+Yo);      % calculate the reflection coefficient
phi=angle(p);               % angle of complex reflection coefficient
xip=abs(p).*cos(phi);       % x-coord of +j*ohms on outer circle of chart
yip=abs(p).*sin(phi);       % y-coord of +j*ohms on outer circle of chart

% Find radius of circle on Imag axis that cuts edge of chart at (xip,yip)

r=(xip^2-2*xip+1+yip^2)/(2*yip);

% Calc arclength to be drawn starting at (1,0)

if r==1,
 arclen=pi/2;
else
  if r<1,
   arclen=pi-atan((1-xip)/(yip-r));
  end
  if r>1,
   arclen=atan((1-xip)/(r-yip));
  end
 end

% Draw arc

theta=(3*pi):(arclen./20):(3*pi+arclen);
x=r.*sin(theta);
y=r.*cos(theta);
plot(-x-1,y+r,'b-');
plot(-x-1,-y-r,'b-');

% Fine tuning for the label positions 

xshift=-0.07;
yshift=0;
xscale=1.12;
yscale=1.07;



% Add -ve Imag Labels

xlp=r.*sin(arclen)-1;       % Basic x-coord of label
xlp=xlp*xscale+xshift;      % Fine tune x-coord
ylp=r.*cos(arclen)-r;       % Basic y-coord of label
ylp=ylp*yscale+yshift;      % Fine tune y-coord

lblp=sprintf('-j%g',imag(mS));             % Construct the label string
text(xlp,ylp,lblp,'FontWeight','bold');    % Add the label



% Add +ve Imag Labels

xlp=r.*sin(arclen)-1;
xlp=xlp*xscale+xshift;
ylp=(-r.*cos(arclen))+r;
ylp=ylp*yscale+yshift;

lblp=sprintf('j%g',imag(mS));
text(xlp,ylp,lblp,'FontWeight','bold');