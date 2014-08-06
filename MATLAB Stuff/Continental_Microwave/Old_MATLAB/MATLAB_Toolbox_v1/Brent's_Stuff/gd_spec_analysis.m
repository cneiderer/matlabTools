function [band,MaxGDW1, MaxGDW2, MaxGDW3, EdgeToEdge] = gd_spec_analysis(file,nstep,GDSmoothie)
% This file reads in data from a text file, specified below, that contains
% frequency in GHz and group delay in seconds and applies the Fixed STE
% Group Delay Specs, chosen with the flags

spec_alpha=0.5;
INTELSATRx    = 0; %toggles Rx option for intelsat
INTELSATTx    = 0; %toggles Tx option for Intelsat
Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
Ku_NCDL_OL    = 0; %toggles Ku NCDL OL spec (15.04-15.34)
Ku_NCDL_IL    = 0; %toggles Ku NCDL IL spec (14.54-14.79)
X_CDL_RL      = 0; %toggles X-Band CDL RL Spec
X_CDL_FL      = 0; %Toggles X-Band CDL FL Spec
% nstep         = 100; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
% GDSmoothie    = 140; %Smoothing factor for Group Delay Information
% ylocdiff      = .8; %Moves the "Meets/Breaks spec" text in y so you can read it better

% file='C:\SAT 1743 Data\System\IRAD2 Data\IRAD RX\11.85 RX.cti';

%[freqin,Sp]=AMCBRENTREAD(file);%use this in case Brent sends you one of his special ".cti" files that really aren't .cti
[freqin,Sp]=Readcti1(file);

freqw=2*pi*freqin;
GDin=(Sp(:,2));
GDinuw=unwrap(angle(GDin));
GDinsm=smooth(GDinuw,GDSmoothie); % This smooths out the phase data in order to keep it from being intolerably noisy from small changes in the phase line that cause the derivative to go apey
delw=freqw(3)-freqw(2);
GD=abs(diff(GDinsm)/delw); %The - sign in front of this may need to be switched depending on how the data was taken

freq=freqin(2:length(freqin));

%Determine the band represented by the file received.
switch(0)
    case(isempty(strfind(file,'11.85')))
        INTELSATRx=1;
    case (isempty(strfind(file,'14.125')))
        INTELSATTx=1;
    case (isempty(strfind(file,'15.25')))
        Ku_CDL_FL=1;
    case (isempty(strfind(file,'14.615')))
        Ku_CDL_RL=1;
    case(isempty(strfind(file,'15.19')))
        Ku_NCDL_OL=1;
    case (isempty(strfind(file,'14.665')))
        Ku_NCDL_IL=1;
    case (isempty(strfind(file,'9.85')))
        X_CDL_FL=1;
    case (isempty(strfind(file,'10.3')))
        X_CDL_RL=1;
end

GDoffset=min(GD(1000:2000));

if (INTELSATRx)% Does not need relaxation DONE
    W1=0.040;
    W2=0.050;
    W3=0.070;
    DLY1=0.8;
    DLY2=1.2;
    DLY3=2.1;
    GDVPERC=0.2;
    exc=0;
    fcmin=10.95+(W3/2);
    fcmax=12.75-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='Intelsat RX';
end 

if (INTELSATTx)% Relaxed DONE
    W1=0.040;
    W2=0.050;
    W3=0.070;
    DLY1=0.7;
    DLY2=1.0;
    DLY3=1.7;
    GDVPERC=0.2;
    exc=0;
    fcmin=13.75+(W3/2);
    fcmax=14.50-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='Intelsat TX';
end

if (Ku_CDL_FL)%% Did not need Relaxing DONE
    W1=0.075;
    W2=0.100;
    W3=0.150;
    DLY1=1.8;
    DLY2=3.0;
    DLY3=5.8;
    GDVPERC=0.2;
    exc=0;
    fcmin=15.15+(W3/2);
    fcmax=15.35-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='Ku CDL FL';
end

if (Ku_CDL_RL)%%RELAXED DONE
    W1=0.150;
    W2=0.200;
    W3=0.300;
    DLY1=1.7;
    DLY2=2.0;
    DLY3=4.9;
    GDVPERC=0.2;
    exc=0;
    fcmin=14.40+(W3/2);
    fcmax=14.83-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='Ku CDL RL';
end

if (Ku_NCDL_OL)%Relaxed DONE
    W1=0.075;
    W2=0.100;
    W3=0.150;
    DLY1=2;%relaxed from 1.8
    DLY2=3;
    DLY3=5.8;
    GDVPERC=0.2;
    exc=0;
    fcmin=15.04+(W3/2);
    fcmax=15.34-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='N-CDL OL';
end

if (Ku_NCDL_IL)% Relax using this wording? : 
    %"As the hubyduber(window) nears the band edges (within 20MHz) the group delay
    %shall meet the specs in tableXX with total excursions not exceeding
    %30 MHz with magnitude 1 ns" DONE
    W1=0.06;
    W2=0.100;
    W3=0.150;
    DLY1=2.0;
    DLY2=4;
    DLY3=6.5;
    GDVPERC=0.2;
    exc=1;
    fcmin=14.54+(W3/2);
    fcmax=14.79-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='N-CDL IL';
end

if (X_CDL_RL)% Relax DLY1 to 2.0 ns and Band Edge Spec to 25% of DLY3 and use following wording:
    % Total excursions in any W3 window shall not exceed 25 MHz and
    % shall not exceed 1 ns. DONE
    W1=0.075;
    W2=0.100;
    W3=0.150;
    DLY1=2.0;
    DLY2=3.0;
    DLY3=6.8;
    GDVPERC=0.25;
    exc=1;
    fcmin=10.15+(W3/2);
    fcmax=10.45-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='X CDL RX';
end

if (X_CDL_FL)% Relax DLY1 to 2.0ns and Band Edge Spec to 25% of DLY3  DONE
    W1=0.075;
    W2=0.100;
    W3=0.150;
    DLY1=2.0;
    DLY2=3.0;
    DLY3=6.8;
    GDVPERC=0.25;
    exc=0
    fcmin=9.75+(W3/2);
    fcmax=9.95-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='X CDL TX';
end

count=0;
n=length(fc);

for ii=1:n
%     fmin=fc(ii)-W3/2;
    fmin=fc(ii)-W3/2;
    fmax=fc(ii)+W3/2;
    nfreq=length(freq);
    for iii=1:nfreq
%         aa=rem(fmin,freq(iii));
        if rem(fmin,freq(iii))<=1 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmin=iii;
        else
            
        end
    end
    for iv=1:nfreq
%         bb=rem(fmax,freq(iv));
        if rem(fmax,freq(iv))<=1 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmax=iv;
        else
            
        end
    end
    
    %find the index for the W1 start and end points
    fminw1=fc(ii)-W1/2;
    fmaxw1=fc(ii)+W1/2;
    indfminw1=find(freq<fminw1, 1, 'last' );
    indfmaxw1=find(freq>fmaxw1, 1 )-1;    
    lengthw1=indfmaxw1-indfminw1;
    
    %find the index for the W2 start and end points and length of W2
    %find the index for the W3 start and end points
    fminw2=fc(ii)-W2/2;
    fmaxw2=fc(ii)+W2/2;
    indfminw2=find(freq<fminw2, 1, 'last' );
    indfmaxw2=find(freq>fmaxw2, 1 )-1;   
    lengthw2=indfmaxw2-indfminw2;
        
    %find the index for the W3 start and end points and length of W3
    %find the index for the W3 start and end points
    fminw3=fc(ii)-W3/2;
    fmaxw3=fc(ii)+W3/2;
    indfminw3=find(freq<fminw3, 1, 'last' );
    indfmaxw3=find(freq>fmaxw3, 1 )-1;   
    lengthw3=indfmaxw3-indfminw3;
    
    L=(indfmax-indfmin)+1;
    GDV=zeros(L,1);
    fDV=zeros(L,1);
    
    GDV=GD(indfmin:indfmax)-GDoffset;
    fDV=freq(indfmin:indfmax);
    
    indmin=find(freq<(fcmin-W3/2),1,'last');
    indmax=find(freq>(fcmax+W3/2),1)-1;
%     for iii=1:length(freq)
%         if rem(fcmin-(W3/2),freq(iii))<=0.0009
%             indmin=iii;
%         end
%         if rem(fcmax+(W3/2),freq(iii))<=0.00008
%             indmax=iii;
%         end
%     end
    
    count=count+1;
    
    %Pick up the max variation w1, w2 and w3
    
    [w1MaxVar(ii),w2MaxVar(ii),w3MaxVar(ii)]=MaxGDVar1(fDV,GDV,lengthw1,lengthw2);
end
MaxGDW1=max(w1MaxVar);
MaxGDW2=max(w2MaxVar);
MaxGDW3=max(w3MaxVar);
EdgeToEdge=abs(GD(indmax)-GD(indmin));
