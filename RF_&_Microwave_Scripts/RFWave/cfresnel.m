% CFRESNEL is the Fresnel cosine integral function.
%
%	       Y = CFRESNEL(X) for 0 < X < 100
%
%   

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function y= cfresnel(xo)

xo(xo==0)=eps;
sxo=size(xo);
y=zeros(sxo);
for i=1:length(xo),
    x=0:xo(i)/1e4:xo(i);
    y(i)=trapz(x,cos(x.^2));
end
y=sqrt(2/pi)*y;

