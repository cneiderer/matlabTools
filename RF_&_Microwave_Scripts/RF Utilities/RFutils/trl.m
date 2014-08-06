function Zs=trl(ZoT,Zr,l,Freq,Er,LdB)
% Transmission line model, Impedance transformation 
%
% ZoT...Characteristic impedance of transmission line.
% Zr....Load impedance (impedance to be transformed).
% l.....Line length in (mm)
% Freq..Frequency (MHz)
% Er....Dielectric constant
% LdB...Loss per unit length dB/m
%
% Usage : Zs=trl(ZoT,Zr,l,Freq,Er,LdB)
%
% All variables may be single values or in 1d array form.
% Vectors for Frequency and Impedance must be the same lengths.
% 
% e.g.  Zs=trl(35,50,56,915,2.2,0.1)
%
%                 or
%
%       ZoT=35      % Line impedance
%       l=55        % Line length (mm)
%       Er=2.2      % Dielectric constant
%       Ldb=0.1     % Loss dB/m
%       
%       Freq=[860,915,960]                 % Frequency list
%       Zlist=[50+j*2,50-j*.01,50-j*2.3]   % Load impedance
%       
%       Zin=trl(ZoT,Zlist,l,Freq,Er,LdB)   % Impedance at input to line

% N.Tucker www.activefrance.com 2008


% Perform impedance transformation.

lalst=3e8./(Freq.*1e6)./sqrt(Er);
At=LdB./8.686;
Bt=2.*pi./lalst;
P=At+Bt.*j;
Pl=P.*l./1000;

Zs=ZoT.*((Zr.*cosh(Pl)+ZoT.*sinh(Pl)) ./ ...
        (ZoT.*cosh(Pl)+Zr.*sinh(Pl))  );


