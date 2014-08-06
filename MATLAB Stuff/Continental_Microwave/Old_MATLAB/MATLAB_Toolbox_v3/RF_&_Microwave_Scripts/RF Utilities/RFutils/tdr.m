function [Dist,R]=tdr(Zin,Zo,Er,Flist);
% Time Domain Reflectometry
% Default display figure(10) 
%
% Usage : [Dist,R]=tdr(Zin,Zo,Er,Freq);
%
%   Start and Stop frequency must conform to :-
%   START FREQ = (STOP FREQ/(No. Of Points))
%
%   e.g.     STOP  = 13.5GHz
%            START = 67.164179MHz
%   
%            (For 201 points)
%
% The range of the measurement is proportional to 1/(freq step)
% The measurement resolution is proportional to (max freq)

% N.Tucker www.activefrance.com 2008

[Row,Npoints]=size(Flist);      % Number of points (Odd Integer)
MaxFreq=Flist(1,Npoints).*1e6;  % Stop Frequency (Hz);

                           
Vfactor=1/sqrt(Er);    % Velocity factor for line, assumes that the all the propagating
                       % electromagnetic fields exist in the dielectric and that the
                       % dielectric constant Er is uniform throughout.
                       % Normal Coaxial line and Stripline conform to this, Microstrip
                       % does not, since some of the fields exist in the air above the
                       % track. 
                       

% Set up vectors dimensions for fft's. These are
% double the length of the measurement vector Flist
% to include the imaginary -ve freq component.

Npts=Npoints;
M=Npts.*2;
Npts=Npts.*2-1;
StopFreq=MaxFreq.*2;
StopFreq=StopFreq-(StopFreq./Npts);
StartFreq=0;
DeltaFreq=StopFreq./(Npts);
RangeTime=1./DeltaFreq;
DeltaTime=RangeTime./Npts;

faxis=StartFreq:DeltaFreq:StopFreq;
taxis=0:DeltaTime:RangeTime;

% Print out the limits of the TDR measurement
RangeDist=(RangeTime*3e8/2)*Vfactor;
ResolDist=(DeltaTime*3e8/2)*1000*Vfactor;
fprintf('\nTDR measurement limits for :\n');
fprintf('Max Freq = %3.3f GHz   Npoints = %i  Er = %3.2f\n',(MaxFreq/1e9),Npoints,Er);
fprintf('Range distance = %3.3g m  (proportional to (1/freq step)\n',RangeDist);
fprintf('Resol distance = %3.3g mm (proportional to (max freq)\n',ResolDist);

v1=zeros(1,M);                 % Initialise voltage vector
v1(1)=1;                       % Impulse stimulus
f1=fft(v1);                    % Fourier Transform of stimulus function this
                               % will be a vector all 1s for a unit impulse

f1=f1./(M./2);                 % Scale
f1=f1.*fftshift(hamming1(M));  % Window function to reduce 'ringing'

[Row,Col]=size(Zin);              
Zin(1,2:Col+1)=Zin;       % Shift impedance data to make room for d.c value
p=(Zin-Zo)./(Zo+Zin);     % Calculate reflection coefficient
p(1,1)=0.00001;           % Set d.c component to zero        

% Modify Flist, just if need for plotting
Flist(1,2:Col+1)=Flist;   % Shift frequency list to make room for d.c value
Flist(1,1)=0;             % Add zero entry for frequency vector

fs1=p(1:M./2);            % Construct 1st half of Freq domain Meas'd data
fs2=p(M./2+1:-1:1+1);     % Construct 2nd half of Freq domain Meas'd data

f2=[f1(1:M./2).*fs1 f1(M./2+1:M).*conj(fs2)];  % Assemble Freq Domain Meas'd data
                                               % vector and scale by window function.

v2=ifft(f2);                                   % Inverse Fourier Transform
v2=v2.*(M./2);                                 % Scale

% v2 now represents the time domain impulse response representation
% of the measured data. To see it remove the '%' from the following
% 3 lines.

%figure(10)
%size(v2)
%plot(taxis,real(v2))

p=cumsum(real(v2));                  % Calculate the real reflection coefficient as
                                     % a function of time.

R=((1+p)./(1-p)).*Zo;                % Convert reflection coefficient to resistance.
Dist=(taxis.*3e8./2)*Vfactor*1000;   % Convert time to distance, scale for Vfactor
                                     % and scale Dist for readout in (mm)
figure(10);

% Plot the measured data as a Return Loss
subplot(211);
Rloss=20.*log10(abs((Zin-Zo)./(Zin+Zo)));
plot(Flist,Rloss);
axis([0,max(Flist),-40,5]);
title('Frequency Domain Response');
ylabel('Return Loss (dB)');
xlabel('Frequency (Hz)');

% Plot the impedance as a function of distance
subplot(212);
plot(Dist,R,Dist,imag(v2),':');     
xlbl=sprintf('Distance From Ref Plane(mm) Er= %3.2f',Er);
xlabel(xlbl);
ylabel('Line Impedance (Ohms)');
title('Time Domain Response');
grid;
zoom on;
