% SI       is the sine integral function.
%
%	       Y = SI(X) for 0 < X < 100
%

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function y = si(xo)

xo(xo==0)=eps;
sxo=size(xo);
y=zeros(sxo);
for i=1:length(xo),
    x=0:xo(i)/1000:xo(i);
    y(i)=trapz(x,sinc(x/pi));
end



