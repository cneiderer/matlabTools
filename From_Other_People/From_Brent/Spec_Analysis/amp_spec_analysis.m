function [MaxAmpW1, MaxAmpW2, slope, dB_MHz] = amp_spec_analysis(file,nstep)
% This file reads in data from three .cti file that contains
% frequency in GHz, and the [RE, IM] S-parameter data.
% It then applies the Fixed STE (SAT 1743 - S
% Amplitude Variation Specs, chosen with the flags.
% Pay attention to the smoothing variables, they can change your outcome
% dramatically.  

spec_alpha=0.5;
INTELSATRx    = 0; %toggles Rx option for intelsat
INTELSATTx    = 0; %toggles Tx option for Intelsat
Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
Ku_NCDL_OL    = 0; %toggles Ku NCDL OL spec (15.04-15.34)
Ku_NCDL_IL    = 0; %toggles Ku NCDL IL spec (14.54-14.79)
X_CDL_RL      = 0; %toggles X-Band CDL RL Spec
X_CDL_FL      = 0; %Toggles X-Band CDL FL Spec
%nstep         = 50; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
%movie         = 0;  %Turns movie option on and off if = 1 the you get a movie if = 0 then you get to watch frame by frame and hit enter to move the window
dBpMHzSMTHFCT = 50; %Smoothing factor for dB/MHz spec section, must be interger greater than 1
AMPYSMTH      = 30; %Smoothing factor for input Amplitude data,must be interger greater than 1

% Added to read in *.cti files or *.s2p files
[filepath,filename,ext]=fileparts(file);
if strcmpi(ext,'.cti')
    [freqin,Sin]=Readcti1(file);
elseif strcmpi(ext,'.s2p')
    [freqin,Sin]=readin_S2P_file(file);
else
    error('File extension is not recognized, file cannot be parsed')
end

freq2=freqin(2:length(freqin));

%freq=freqin;
%Comment next 3 lines if using ReadMarkFile
AMPin=(Sin(:,2));
AMPindB=20*log10(abs(AMPin)); %Puts data into dB
AMPY=smooth(AMPindB,AMPYSMTH); %Smooths the data from the cut if needed.

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

if (INTELSATTx)%Relaxed DONE
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=13.75 && freqin(ii)<=14.5
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.040;
    W2=0.070;
    RPL1=0.65;
    RPL2=0.85;
    exc=0;
    dBMHz=0.03;
    band='Intelsat TX';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
end
if (INTELSATRx)%relax and with wording DONE
    %Total excursions in any W2 window shall not exceed 40 MHz in bandwidth with magnitude
    %<= 0.4 dB beyond spec
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=10.95 && freqin(ii)<=12.75
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.040;
    W2=0.070;
    RPL1=0.45;
    RPL2=0.65;
    exc=0.4;
    dBMHz=0.03;
    band='Intelsat RX';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;

end



if (Ku_CDL_FL)%Relaxed and with wording DONE
    %Total excursions in any W2 window shall not exceed 20 MHz in bandwidth
    %with magnitude <=0.2 dB beyond spec constraint
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=15.15 && freqin(ii)<=15.35
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.45;
    RPL2=0.75;
    exc=0.2;
    dBMHz=0.055;
    band='Ku-CDL FL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;

end

if (Ku_CDL_RL)%Relax and with wording DONE
    %Total excursions in any W2 window shall not exceed 20 MHz bandwidth
    %with magnitude <=0.2 dB beyond spec

    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=14.40 && freqin(ii)<=14.83
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.150;
    W2=0.300;
    RPL1=0.6;
    RPL2=1.1;
    exc=0.2;
    dBMHz=0.06;
    band='Ku-CDL RL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
end
  
    

    
if (Ku_NCDL_OL)%Relax DONE
    %Total excusrions in any W2 window shall not exceed 25MHz bandwidth and
    %magnitude <= 0.25 dB beyond spec

    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=15.04 && freqin(ii)<=15.34
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.4;
    RPL2=0.6;
    exc=0.25;
    dBMHz=0.035;
    band='Ku N-CDL OL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;

end

if (Ku_NCDL_IL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 25MHz with
    %magnitude of <= 0.25 dB beyond spec
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=14.54 && freqin(ii)<=14.79
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.4;
    RPL2=0.7;
    exc=0.25;
    dBMHz=0.055;
    band='Ku N-CDL IL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;

end

if (X_CDL_RL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 45MHz in bandwidth
    %and 0.5 dB in mag beyond spec
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=10.15 && freqin(ii)<=10.45
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.6;
    RPL2=0.8;
    exc=0.5;
    dBMHz=0.1;
    band='X-CDL RL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;


end
if (X_CDL_FL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 10MHz bandwidth
    %with magnitude of 0.2 dB beyond spec
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=9.75 && freqin(ii)<=9.95
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.4;
    RPL2=0.6;
    exc=0.2;
    dBMHz=0.08;
    band='X-CDL FL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
end 

countmonger=0;

n=length(fc);
for ii=1:n
    fmin=fc(ii)-W2/2;
    fmax=fc(ii)+W2/2;
    nfreq=length(freq);
    %finds the indexes for the W2 start and end points
    for iii=1:nfreq
        if rem(fmin,freq(iii))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmin=iii;
        else if rem(fmax,freq(iii))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
                indfmax=iii;

            else end
        end
    end
    
    %find the index for the W1 start and end points
    fminw1=fc(ii)-W1/2;
    fmaxw1=fc(ii)+W1/2;
    iii=1;
    for iii=1:nfreq
        if rem(fminw1,freq(iii))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfminw1=iii;
        else

        end
    end
    iv=1;
    for iv=1:nfreq
        if rem(fmaxw1,freq(iv))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmaxw1=iv;
        else

        end
    end
    
    lengthw1=indfmaxw1-indfminw1;

    L=(indfmax-indfmin)+1;

    SLA=polyfit(freq,AMP,1);  % this section makes a straight line approximation across the passband

    AMPSLA=(SLA(1).*freq)+SLA(2);

    peacemaker=AMP+(max(AMPSLA)-AMPSLA);
%     peacemakerSLA=AMPSLA+(max(AMPSLA)-AMPSLA);
    
    PMAVV=zeros(L,1);
    PMfDV=zeros(L,1);
    
    PMAVV=peacemaker(indfmin:indfmax);
    PMfDV=freq(indfmin:indfmax);

    
    [w1MaxVar(ii),w2MaxVar(ii)]=MaxAmpVar1(PMfDV,PMAVV,lengthw1);   
     countmonger=countmonger+1;
end

 %%%%%%%%%%%%%%%%%%dB/MHz spec section%%%%%%%%%%%%%%%%%%%%%%%


    freqMHz=freq*1000;
    delfMHz=freqMHz(2)-freqMHz(1);
    dBperMHz=(diff(AMP)/delfMHz);
    for xxx=2:length(freqMHz)
        freqMHzplot(xxx-1)=freqMHz(xxx)/1000;
    end
    dBsmoothie=smooth1(dBperMHz,dBpMHzSMTHFCT); %This smoothing may need to be adjusted to make this make sense maybe leave a bit of noise on it to be sure the overall trace is not greatly changed
    
    if abs(max(dBsmoothie))<=dBMHz && abs(min(dBsmoothie))<=dBMHz
        dBMHzmax=max(dBsmoothie);
        dBMHzmin=min(dBsmoothie);
        if abs(dBMHzmax)>abs(dBMHzmin)
            dBMHzval=abs(dBMHzmax);
        else
            dBMHzval=abs(dBMHzmin);
        end
    elseif abs(max(dBsmoothie))>=dBMHz || abs(min(dBsmoothie))>=dBMHz
        dBMHzmax= max(dBsmoothie);
        dBMHzmin= min(dBsmoothie);
        if abs(dBMHzmax)>abs(dBMHzmin)
            dBMHzval=abs(dBMHzmax);
        else
            dBMHzval=abs(dBMHzmin);
        end
    end
    
slope=max(AMPSLA)-min(AMPSLA);
dB_MHz=dBMHzval;
MaxAmpW1=max(w1MaxVar);
MaxAmpW2=max(w2MaxVar);
