%
% HATA     Provides, for a radio link, the path loss (dB) using HATA
%          and COST-231 models.  The free-space path loss is include 
%          in the calculation.
%
%          L = HATA(fc,hte,hre,d,type)
%
%          The link frequency  fc is given in  MHz.  Antenna heigths 
%          are at the transmitter  hte and receiver hre are given in
%          meter. The link separation distance is in km. The type of
%          environment allowed are:
%               - 1, urban area;
%               - 2, suburban area;
%               - 3, rural area.
%          Note: fc must range from  150 to 2000MHz,  hte from 30 to
%          200m, hre from 1 to 10m, d from 1 to 20km.

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.3 25-May-2005
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function L = hata(fc,hte,hre,d,type)

% fc check
if fc < 150 | fc > 2000
   error('Frequency must be within the range 150-2000MHz');
end

% hte check
if hte < 30 | hte > 200
   error('Height hte must be within the range 30-200m');
end

% hre check
if hre < 1 | hre > 10
   error('Height hre must be within the range 1-10m');
end

% d check
if d < 1 | d > 20
   error('Separation d must be within the range 1-20km');
end

% type check
if type ~=1 & type ~=2 & type ~=3
   error('type must be 1, 2 or 3');
end

% Area coverage correction factor
a = (1.1*log10(fc)-0.7)*hre-(1.56*log10(fc)-0.8);

% Path loss calculation

if fc > 1500,
    Lu = 69.55+26.16*log10(fc)-13.82*log10(hte)-a+(44.9-6.55*log10(hte))*log10(d);    
    switch type
    case 1 
        L = Lu;
    case 2
        L = Lu-2*(log10(fc/28))^2-5.4;
    case 3
        L = Lu-4.78*(log10(fc))^2+18.33*log10(fc)-40.94;
    end
else
    Lu = 46.3+33.9*log10(fc)-13.82*log10(hte)-a+(44.9-6.55*log10(hte))*log10(d);  
    switch type
    case 1 
        L = Lu+3;
    case 2
        L = Lu-2*(log10(fc/28))^2-5.4;
    case 3
        L = Lu-4.78*(log10(fc))^2+18.33*log10(fc)-40.94;
    end  
end
        
   




