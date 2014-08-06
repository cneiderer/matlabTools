% ZOIMP    Provides the characteristic impedances for N quarter-wave
%          transformers in cascade.
%
%	       ZO = QWTRAFOS(ZL,ZD,N)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively. 

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function zo = qwtrafos(zl,zd,n)
 
fatn=prod(1:n);
n2=2^(-n);
zld=(zl/zd)^(2^(-n));
for i=1:1:n,    
    cnn=fatn/(prod(1:n-i+1)*prod(1:i-1));
    zo(i)=zd*zld^cnn;
    zd=zo(i);
end

