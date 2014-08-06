% LARRAY   Provides the radiation intensity UA for an uniform linear
%          array in which the elements are parallel to each other. 
%
%          UA = LARRAY(U,D,BETA,N)
%
%          U is the radiation intensity vector of the elements, D is
%          the elements spacing interval in wavelength,  BETA is the
%          feeding phase difference between elements in degree and N
%          the number of elements.
%

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function ua = larray(u,d,psia,n)

if u==1
    lu=200;
else
    lu=length(u)/2;
end

% Radiation intensity
k=2*pi;
th=pi/lu:pi/lu:2*pi;
psi=k*d*cos(th)+psia;
ar=sin(n*psi/2)./(n*sin(psi/2));
ua=u.*ar.^2;
uam=max(ua);
ua=ua/uam;



