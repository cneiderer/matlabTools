% RADAR    Provides, for a radar link,  either the received power in
%          dBm or transmitted power in W,  depending on  the type of
%          calculation selected. 
%
%          POUT = RADAR(TYPE,PIN,D,F,GA,ATT,AE)
%
%          If  TYPE = 1  then PIN is the transmitted power in W;  If  
%          TYPE = 2 then PIN is the received power in dBm.  D is the
%          distance (in km) between  the transceiver and the target, 
%          F  is the operating frequency  in MHz,  GA is the antenna 
%          gain in dBi and ATT is the extra attenuation due to cabes
%          and conectors.  Finally,  AE  is the target  echo area in 
%          square meter.         

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function  pout = radar(type,pin,d,f,ga,att,ae)

% Some convertion 
f=f*1e6;
d=d*1e3;
c=3e8;
lbd=c/f;
ga=10^(ga/10);
if type == 1
    % Provides the received power in dBm
    pout = pin*ae/4/pi*(ga*lbd/4/pi/d^2)^2;
    pout = 10*log10(pout*1000);
    
elseif type == 2
    % Provides the transmitted power in W
    pin = 10^(pin/10)/1000;
    pout = pin*4*pi/ae/(ga*lbd/4/pi/d^2)^2; 
    
else
    error('TYPE must be either 1 or 2.');
end
    
    
    
    
    