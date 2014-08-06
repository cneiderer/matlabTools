function scsub2(ohms,Zo)
% Smith / Admittance Chart Subroutine2
% Draws circles on the imaginary axis, radius r at locn (1,r)
%
% Calculates cropping point on smith chart circle
% Then draws arcs for +j and -j
%
% ohms....Impedance circle to be drawn
% Zo......Normalising impedance
%
% Called by scomb.m

% N.Tucker www.activefrance.com 2008

% Find (x,y) point on chart corresponding to +j*(ohms)

ohms=ohms*j;                % convert ohms to imaginary value
p=(ohms-Zo)/(ohms+Zo);      % calculate the reflection coefficient
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

% Draw arcs

theta=0:(arclen./20):arclen;
x=-r.*sin(theta);
y=-r.*cos(theta);
plot(x+1,y+r,'b-');         % Plot +ve Imag arcs, centred at (1,0)
plot(x+1,-y-r,'b-');        % Plot -ve Imag arcs, centred at (1,0)
plot(-x-1,y+r,'b:');
plot(-x-1,-y-r,'b:');


% Fine tuning for the label positions 

xshift=-0.07;
yshift=0;
xscale=1.12;
yscale=1.07;



% Add +ve Imag Labels

xlp=-r.*sin(arclen)+1;       % Basic x-coord of label
xlp=xlp*xscale+xshift;       % Fine tune x-coord
ylp=-r.*cos(arclen)+r;       % Basic y-coord of label
ylp=ylp*yscale+yshift;       % Fine tune y-coord

lblp=sprintf('j%g',imag(ohms));          % Construct the label string
text(xlp,ylp,lblp,'FontWeight','bold');  % Add the label



% Add -ve Imag Labels

xlp=-r.*sin(arclen)+1;
xlp=xlp*xscale+xshift;
ylp=-(-r.*cos(arclen))-r;
ylp=ylp*yscale+yshift;

lblp=sprintf('-j%g',imag(ohms));
text(xlp,ylp,lblp,'FontWeight','bold');