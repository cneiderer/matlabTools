function Zinterp=samarker1(Z,Freq,Zo,Marker,Mnumber)
% Admittance Chart Marker
%
% Draws a single marker on Admittance Chart at frequency 
% specified in Marker. Returning the interpolated 
% Z value in mS. It allows individual markers to be applied 
% to different impedance plots.
%
% Usage: Zinterp=samarker1(Z,Flist,Zo,Marker,Mnumber)
%   
% Z........Impedance vector to be marked (Ohms)
% Freq.....Frequency list (MHz)
% Zo.......Characteristic impedance of the chart (Ohms)
% Marker...Marker frequency, a single value (MHz)
% Mnumber..Marker number, 1-8
%
% e.g. 
%      Freq=800:10:1000;
%      smith(1,50);
%      smdrawc(Zload,50,'-b');
%      smdrawc(Zin,50,'-g');     
%      Marker=[870];
%      Zinterp=samarker1(Z,Freq,Zo,Marker,1)
%      Zinterp=samarker1(Zin,Freq,Zo,Marker,2)
%

% N.Tucker www.activefrance.com 2008

Z=(1./Z)*1000;   % Convert to admittance
Zo=(1/Zo)*1000;  % Convert to admittance

axis('square');


[RowF,ColF]=size(Freq);
[RowZ,ColZ]=size(Z);
[RowM,ColM]=size(Marker);

if ColZ>ColF
 Z=Z(1,1:ColF);
end

index=zeros(1,ColM);
interp=zeros(1,ColM);

M=1;
if Marker(M)<=min(Freq),
  Marker(M)=Freq(1,1);
 end
 if Marker(M)>=max(Freq),
  Marker(M)=Freq(1,ColF)-0.0001;
 end


M=1;
for N=2:ColF,         % Loop thru freqs
   if (Marker(M)>=Freq(N-1)) & (Marker(M)<Freq(N)),
   index(M)=N;
   end
  end

  M=1;
  F2=Freq(index(M));
  F1=Freq(index(M)-1);
  interp=(Marker(M)-F1)./(F2-F1);
  Z2=Z(index(M));
  Z1=Z(index(M)-1);
  Ymarker(M)=Z1+interp.*(Z2-Z1);

Xmarker=Marker;
Zinterp=conj(Ymarker);


p=(Ymarker-Zo)./(Ymarker+Zo);
phi=angle(p);
x=abs(p).*cos(phi);
y=abs(p).*sin(phi);
plot(-x,-y,'+','color','k','linewidth',2);

I=1;
 t=sprintf(' %g',Mnumber);
 text(-x(I),-y(I),t,'FontWeight','Bold');

RHSx=0.88;  % Marker text position for markers on RHS
LHSx=-0.28; % Marker text position for markers on LHS

if Mnumber==1
 t1=sprintf('1)  %g Mhz',Marker(1));
 t1a=sprintf('%5.2f mS',real(Zinterp(1)));
 t1b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(RHSx,.90,t1);
 textsc(RHSx,.85,t1a);
 textsc(RHSx,.80,t1b);
end

if Mnumber==2
 t2=sprintf('2)  %g Mhz',Marker(1));
 t2a=sprintf('%5.2f mS',real(Zinterp(1)));
 t2b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(RHSx,.70,t2);
 textsc(RHSx,.65,t2a);
 textsc(RHSx,.60,t2b);
end

if Mnumber==3
 t3=sprintf('3)  %g Mhz',Marker(1));
 t3a=sprintf('%5.2f mS',real(Zinterp(1)));
 t3b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(RHSx,.50,t3);
 textsc(RHSx,.45,t3a);
 textsc(RHSx,.40,t3b);
end

if Mnumber==4
 t4=sprintf('4)  %g Mhz',Marker(1));
 t4a=sprintf('%5.2f mS',real(Zinterp(1)));
 t4b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(RHSx,.30,t4);
 textsc(RHSx,.25,t4a);
 textsc(RHSx,.20,t4b);
end

% Marker 5-8 On LHS

if Mnumber==5
 t1=sprintf('5)  %g Mhz',Marker(1));
 t1a=sprintf('%5.2f mS',real(Zinterp(1)));
 t1b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(LHSx,.90,t1);
 textsc(LHSx,.85,t1a);
 textsc(LHSx,.80,t1b);
end

if Mnumber==6
 t2=sprintf('6)  %g Mhz',Marker(1));
 t2a=sprintf('%5.2f mS',real(Zinterp(1)));
 t2b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(LHSx,.70,t2);
 textsc(LHSx,.65,t2a);
 textsc(LHSx,.60,t2b);
end

if Mnumber==7
 t3=sprintf('7)  %g Mhz',Marker(1));
 t3a=sprintf('%5.2f mS',real(Zinterp(1)));
 t3b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(LHSx,.50,t3);
 textsc(LHSx,.45,t3a);
 textsc(LHSx,.40,t3b);
end

if Mnumber==8
 t4=sprintf('8)  %g Mhz',Marker(1));
 t4a=sprintf('%5.2f mS',real(Zinterp(1)));
 t4b=sprintf('%5.2fj',imag(Zinterp(1)));
 textsc(LHSx,.30,t4);
 textsc(LHSx,.25,t4a);
 textsc(LHSx,.20,t4b);
end

