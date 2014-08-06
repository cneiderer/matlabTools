function Sinterp=gmarker1(Snn,Freq1,Zo,Markers,Mnumber)
% Group Delay Marker
%
% Draws a single marker on Group Delay plot at frequency specified
% by Marker. Returning the interpolated S-param value. It allows 
% individual markers to be applied to different plots.
%
% Usage: Sinterp=phmarker1(Snn,Freq,Zo,Marker,Mnumber)
%
% Snn......S-parameter (linear complex)
% Freq1....Frequency list (MHz)
% Zo.......Characteristic impedance (Ohms)
% Marker...Marker frequency (MHz)
% Mnumber..Marker number 1-8
%
% e.g. phdelayc(S21,Freq,Zo);
%      phmarker1(S21,Freq,50,880,1)

% N.Tucker www.activefrance.com 2008

axis('square');

[Row,Col]=size(Freq1);
Freq=Freq1(1,2:(Col));   % Match Freq vector length to the differential
                         % vector Grp. (With one less data point) 
                         
Pha=(unwrap(angle(Snn)).*180./pi);         % Unwrap the phase data
Grp=-(diff(Pha)./(diff(Freq1.*1e6)))./360; % Calc grp-dly d(pha)/d(freq)


Z=Grp;
[RowF,ColF]=size(Freq);
[RowZ,ColZ]=size(Z);
[RowM,ColM]=size(Markers);

if ColZ>ColF
 Z=Z(1,1:ColF);
end

index=zeros(1,ColM);
interp=zeros(1,ColM);

M=1;
if Markers(M)<=min(Freq),
  Markers(M)=Freq(1,1);
 end
 if Markers(M)>=max(Freq),
  Markers(M)=Freq(1,ColF)-0.0001;
 end


M=1;
for N=2:ColF,         % Loop thru freqs
   if (Markers(M)>=Freq(N-1)) & (Markers(M)<Freq(N)),
   index(M)=N;
   end
  end

  M=1;
  F2=Freq(index(M));
  F1=Freq(index(M)-1);
  interp=(Markers(M)-F1)./(F2-F1);
  Z2=Z(index(M));
  Z1=Z(index(M)-1);
  Ymarker(M)=Z1+interp.*(Z2-Z1);

Xmarker=Markers;
Zinterp=Ymarker;


hold on;
L1=Ymarker;    % Group Delay (Secs)
plot(Xmarker,Ymarker,'+','color','k','LineWidth',2);

RHSx=0.88;  % Marker text position for markers on RHS
LHSx=-0.28; % Marker text position for markers on LHS


% Markers 1-4 RHS

I=1;
 t=sprintf(' %g',Mnumber);
 text(Xmarker(I),L1(I),t,'FontWeight','bold');

if Mnumber==1
 t1=sprintf('1) %g Mhz',Markers(1));
 t1a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(RHSx,.90,t1);
 textsc(RHSx,.85,t1a);
end


if Mnumber==2
 t2=sprintf('2) %g Mhz',Markers(1));
 t2a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(RHSx,.70,t2);
 textsc(RHSx,.65,t2a);
end

if Mnumber==3
 t3=sprintf('3) %g Mhz',Markers(1));
 t3a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(RHSx,.50,t3);
 textsc(RHSx,.45,t3a);
end

if Mnumber==4
 t4=sprintf('4) %g Mhz',Markers(1));
 t4a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(RHSx,.30,t4);
 textsc(RHSx,.25,t4a);
end

% Markers 5-8 LHS

if Mnumber==5
 t1=sprintf('5) %g Mhz',Markers(1));
 t1a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(LHSx,.90,t1);
 textsc(LHSx,.85,t1a);
end


if Mnumber==6
 t2=sprintf('6) %g Mhz',Markers(1));
 t2a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(LHSx,.70,t2);
 textsc(LHSx,.65,t2a);
end

if Mnumber==7
 t3=sprintf('7) %g Mhz',Markers(1));
 t3a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(LHSx,.50,t3);
 textsc(LHSx,.45,t3a);
end



if Mnumber==8
 t4=sprintf('8) %g Mhz',Markers(1));
 t4a=sprintf('%5.3g Sec',real(L1(1)));
 textsc(LHSx,.30,t4);
 textsc(LHSx,.25,t4a);
end


hold off;






