% MUTIMP   Provides the mutual impedance between dipoles placed side
%          by side.
%
%          ZIJ = MUTIMP(D,L1,L2,TYPE)
%
%          D is the dipoles separation (centre to centre), L1 and L2
%          are the dipole lengths and TYPE is 1 for dipoles parallel
%          to each other and 2 for collinear dipoles. All dimensions
%          must be given in wavelength. 
% 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function zij = mutimp(d,l1,l2,type)

k=2*pi;
kl1=k*l1/2;
kl2=k*l2/2;
if type==1
    % Parallel dipoles
    z=-l2/2:l2/100:l2/2;
    r1=sqrt(d^2+(z-l1/2).^2);
    r2=sqrt(d^2+(z+l1/2).^2);
    r=sqrt(d^2+z.^2);
    eij=exp(-j*k*r1)./r1+exp(-j*k*r2)./r2-2*cos(kl1)*exp(-j*k*r)./r;
    eij=eij.*sin(kl2-k*abs(z));
    zij=trapz(z,eij);
    zij=j*30*zij/(sin(kl1)*sin(kl2));
else
    % Collinear dipoles
    z=d-l2/2:l2/100:d+l2/2;
    eij=(exp(j*kl1)./(2*z-l1)+exp(-j*kl1)./(2*z+l1)-cos(kl1)./z).*exp(-j*k*z);
    eij=eij.*sin(kl2-k*abs(z-d));
    zij=trapz(z,eij);
    zij=j*60*zij/(sin(kl1)*sin(kl2));
end
