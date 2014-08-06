% FRIIS    Provides, for  a radio link,  the received power  in W or 
%          dBm, depending on  the type  of calculation selected. AFE 
%          and AOBS are the free-space and obstacle losses in dB.
%
%          [POUT, AFE, AOBS] = FRIIS(TYPE,PIN,D,F,GA,ATT,DO,H,RC)
%
%          If  TYPE = 1  then transmitted power PIN and the received 
%          power POUT are render in W; If TYPE = 2 then PIN and POUT
%          are render in dBm. D is the radio link length and  DO the
%          distance between the transmiter and the obstacle, both in
%          kilometers.  F is  the operating  frequency in MHz, GA is
%          the total gain in dBi due to the antennas and  ATT is the
%          extra  attenuation  due to cabes, conectors and polariza-
%          tion.  The height H is the measure  between  the  line of
%          sight  and  the top of the obstacle  whereas  RC  is  the
%          curvature  radius of this obstacle, both variable must be
%          provided in meters. If RC is equal to zero or  not given,
%          the obstacle  will be consider as a  knife edge.  If  DO,
%          H  and  RC  are not  provided  then  no  obstacle loss is
%          consider.
%         

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function  [pout,afe,aobs] = friis(type,pin,d,f,ga,att,do,h,rc)

if nargin < 9
    rc=0;
end

% Obstacle loss
if nargin < 7
    aobs=0;
else    
    [aobs,rf]=obloss(d,do,f,h,rc);
end

% Some convertion 
f=f*1e6;
d=d*1e3;
c=3e8;
lbd=c/f;

% Free-space loss
afe=20*log10(4*pi*d/lbd);

if type == 1
    % Provides the received power in dBm
    pin = 10*log10(pin*1000);
    pout = pin+ga-afe-att-aobs; 
    pout = 10^(pout/10)/1000;
    
elseif type == 2
    % Provides the transmitted power in W
    pout = pin+ga-afe-att-aobs;
    
else
    error('TYPE must be either 1 or 2.');
end
    
    
    
    
    