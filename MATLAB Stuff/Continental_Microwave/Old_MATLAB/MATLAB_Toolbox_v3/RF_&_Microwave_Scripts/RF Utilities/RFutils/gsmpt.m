function Zpts=gsmpt(npts,Zo)
% Graphics Point
%
% Show impedance at points on Smith Chart selected by mouse.
%
% Usage: Zpts=gsmpt(npts,Zo);
%
% Where npts is the number of labels to be placed (8 max).

% N.Tucker www.activefrance.com 2008

if npts<1,
 npts=1;
end

if npts>8,
 npts=8;
end
zoom off;
hold on;

count=1;
while count<(npts+1),
 [x,y]=ginput(1);
 p=x+j.*y;
 Z=Zo.*(p+1)./(1-p);
 plot(x,y,'gx');
 T=sprintf('%g',count);
 text(x,y,T);
 T1=sprintf('%g %5.2f Ohms ',count,real(Z));
 T2=sprintf('   %5.2f j',imag(Z));
 textsc(-0.3,(1.05-0.12.*count),T1);
 textsc(-0.3,(1.00-0.12.*count),T2);
 Zpts(count)=Z;
 count=count+1;
end
hold off;