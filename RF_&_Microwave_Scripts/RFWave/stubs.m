% STUBS    Provides the line lengths L and stub length LT.
%          
%	       [L,LT] = STUBS(ZL,ZO,ZD,ST)
%
%          ZL, ZO  and  ZD  are the load, characteristic and desired
%          impedances, respectively. Whereas:
%
%          ST=10 means short-circuit stub near the generator; 
%          ST=11 means open-circuit stub near the generator;
%          ST=20 means short-circuit stub near the load; 
%          ST=21 means open-circuit stub near the load.    
%

% RFWave - The Radio Frequency Wave Toolbox
% Versions: 1.0 22-May-1997, 1.1 18-Aug-1999,
%           1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [l,lt] = stubs(zl,zo,zd,st)

warning('off');
yl=zo/zl;
yin=zo/zd;

if st == 11 | st == 10
    % Line length l
    g=inline('abs(real((yl+j*tan(2*pi*x))/(1+j*yl*tan(2*pi*x)))-real(yin))','x','yl','yin');
    l=fminbnd(g,0,0.5,optimset('TolX',1e-12,'Display','off'),yl,yin);
   
    % Stub length lt
    tgbl=tan(2*pi*l);
    yeq=(yl+j*tgbl)/(1+j*yl*tgbl);

    if st == 11      
        g=inline('abs(imag(j*tan(2*pi*x))+imag(yeq)-imag(yin))','x','yeq','yin');
    else
        g=inline('abs(imag(-j./(tan(2*pi*x)+eps))+imag(yeq)-imag(yin))','x','yeq','yin');
    end
    lt=fminbnd(g,0,0.5,optimset('TolX',1e-12,'Display','off'),yeq,yin);
elseif st == 21 | st == 20 
    % Stub length lt
    mrho=abs((1-yin)/(1+yin));
    swin=(1+mrho)/(1-mrho);
    if st == 21 
        g=inline('abs(swin-(1+abs((1-(yl+j*tan(2*pi*x)))/(1+(yl+j*tan(2*pi*x)))))/(1-abs((1-(yl+j*tan(2*pi*x)))/(1+(yl+j*tan(2*pi*x))))))','x','swin','yl');
    else
        g=inline('abs(swin-(1+abs((1-(yl-j./(tan(2*pi*x)+eps)))/(1+(yl-j./(tan(2*pi*x)+eps)))))/(1-abs((1-(yl-j./(tan(2*pi*x)+eps)))/(1+(yl-j./(tan(2*pi*x)+eps))))))','x','swin','yl');
    end
    lt=fminbnd(g,0,0.5,optimset('TolX',1e-12,'Display','off'),swin,yl);
    % Line length l
    tglt=tan(2*pi*lt);
    if st == 21 
       yt=j*tglt;
    else
       yt=-j./(tglt+eps);
    end 
    g=inline('abs((yl+yt+j*tan(2*pi*x))/(1+j*(yl+yt)*tan(2*pi*x))-yin)','x','yl','yin','yt');
    l=fminbnd(g,0,0.5,optimset('TolX',1e-12,'Display','off'),yl,yin,yt);
else
    error('ST must be 10, 11, 20 or 21.');
end

% VSWR check
[vswr,rho,zin]=stub(zl,zo,zd,l,lt,st,0);
if vswr < 1 | vswr > 1.000001
   error('The network is not suitable! VSWR different of 1.');
end     
warning('on');