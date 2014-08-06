%Example4
%
% 5-Section Cheby Filter Example
% Modelled as cascaded transmission lines.
%
% Starting at the termination impedance of 50 ohms this single point
% impedance is 'wound' round succesive sections differing characteristic
% impedance line, over the frequency range specified by Freq, see below.
%
%  I/P Connection  |......   filter  ......| Connection  O/P
%                  |                       |
%        50   50   100   25   100   25   100   50   50          <-Characteristic Z
%  Zin>----Z7-----Z6--Z5---Z4-----Z3---Z2---Z1----Za-----<Zload <-Node Impedances
%
% Note :- The Mismatch Loss plotted in this example is different to
%         Transmission Loss(S21). Here they only have the same value 
%         because all components are lossless.

% N.Tucker www.activefrance.com 2008

clc;
close all;
fprintf('\n\n\n***** Example 4 *******\n\n\n')
help example4;

% Define constants
Freq=500:10:2000;   % Frequency sweep (MHz)
Er=3.9;             % Dielectric constant 3.9
LdB=0;              % dB Loss/m

% Marker frequencies
Mkr1=870;
Mkr2=960;
Mkr3=1710;
Mkr4=1880;

Zo=50;                        % Input line characteristic impedance
Zlow=25;                      % Filter impedance (low 25)
Zhigh=100;                    % Filter impedance (high 100)


% *************   CALCULATE IMPEDANCE NODE LIST ********************

Zload=term(50,Freq);
Za=trl(Zo,Zload,30,Freq,2.1,LdB);          % 50 ohm semi-rigid. Er=2.1
Z1=trl(Zo,Za,20,Freq,Er,LdB);              % 50 ohm microstrip 20mm
Z2=trl(Zhigh,Z1,14.6,Freq,Er,LdB);         % 100 ohm microstrip 14.6mm
Z3=trl(Zlow,Z2,14.7,Freq,Er,LdB);          % 25 ohm microstrip 14.7mm
Z4=trl(Zhigh,Z3,21.9,Freq,Er,LdB);         % etc...
Z5=trl(Zlow,Z4,14.7,Freq,Er,LdB);
Z6=trl(Zhigh,Z5,14.6,Freq,Er,LdB);
Z7=trl(Zo,Z6,20,Freq,Er,LdB);
Zin=trl(Zo,Z7,35,Freq,2.1,LdB);             % 50 ohm semi-rigid. Er=2.1


% ******************* DISPLAY VARIOUS GRAPHS *************************

% SMITH CHART
smith(1,50);
smdrawc(Zin,50,'g-')
smarker1(Zin,Freq,50,Mkr1,1);
smarker1(Zin,Freq,50,Mkr2,2);
smarker1(Zin,Freq,50,Mkr3,3);
smarker1(Zin,Freq,50,Mkr4,4);


% RETURN LOSS dB
rlossc(Zin,Freq,50,'g-');
rmarker1(Zin,Freq,50,Mkr1,1);
rmarker1(Zin,Freq,50,Mkr2,2);
rmarker1(Zin,Freq,50,Mkr3,3);
rmarker1(Zin,Freq,50,Mkr4,4);

% MISMATCH LOSS dB
mlossc(Zin,Freq,50,'g-');
mmarker1(Zin,Freq,50,Mkr1,1);
mmarker1(Zin,Freq,50,Mkr2,2);
mmarker1(Zin,Freq,50,Mkr3,3);
mmarker1(Zin,Freq,50,Mkr4,4);
