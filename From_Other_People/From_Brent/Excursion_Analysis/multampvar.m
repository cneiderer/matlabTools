function multampvar = multampvar
% This file reads in data from two .cti file that contains
% frequency in GHz and Magnitude in dB and applies the Fixed STE
% Amplitude Variation Specs, chosen with the flags
% Pay attention to the smoothing variables, they can change your outcome
% dramatically.  

clear;

spec_alpha=0.5;
INTELSATRx    = 1; %toggles Rx option for intelsat
INTELSATTx    = 0; %toggles Tx option for Intelsat
Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
KU_NCDL_OL    = 0; %toggles Ku NCDL OL spec (15.04-15.34)
KU_NCDL_IL    = 0; %toggles Ku NCDL IL spec (14.54-14.79)
X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
X_Tx_CDL_FL   = 0; %Toggles X-Band CDL FL Spec
nstep         = 50; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
movie         = 0;  %Turns movie option on and off if = 1 the you get a movie if = 0 then you get to watch frame by frame and hit enter to move the window
dBpMHzSMTHFCT = 50; %Smoothing factor for dB/MHz spec section, must be interger greater than 1
AMPYSMTH      = 30; %Smoothing factor for input Amplitude data,must be interger greater than 1

file='C:\SAT 1743 Data\System\SAT1736SN005\RX\11.85.cti';
file2='C:\SAT 1743 Data\System\IRAD2 Data\IRAD RX\11.85 RX.cti';


%[freqin,Sin]=AMCBRENTREAD(file);%use this in case Brent sends you one of his special ".cti" files that really aren't .cti
%[freqin,AMPY]=ReadMarkFile(file);%use this to read AMC Excel files with freq,
%LM data
[freqin,Sin]=Readcti(file);
[freqin2,Sin2]=Readcti(file2);

%freq=freqin;
%Comment next 3 lines if using ReadMarkFile
AMPin=(Sin(:,2));
AMPindB=20*log10(abs(AMPin)); %Puts data into dB
AMPY=smooth(AMPindB,AMPYSMTH); %Smooths the data from the cut if needed.

AMPin2=(Sin2(:,2));
AMPindB2=20*log10(abs(AMPin2)); %Puts data into dB
AMPY2=smooth(AMPindB2,AMPYSMTH); %Smooths the data from the cut if needed.

%AMPY=AMPindB;

if (INTELSATTx)%Relaxed DONE
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=13.75 && freqin(ii)<=14.5
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.040;
    W2=0.070;
    RPL1=0.65;
    RPL2=0.85;
    GS=0.6;
    dBMHz=0.03;
    exc=0;
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
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.040;
    W2=0.070;
    RPL1=0.45;
    RPL2=0.65;
    GS=1.1;
    dBMHz=0.03;
    exc=0.4;
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
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.45;
    RPL2=0.75;
    GS=0.3;
    dBMHz=0.055;
    exc=0.2;
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
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.150;
    W2=0.300;
    RPL1=0.6;
    RPL2=1.1;
    GS=0.75;
    dBMHz=0.06;
    exc=0.2;
    band='Ku-CDL RL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
end
  
    

    
if (KU_NCDL_OL)%Relax DONE
    %Total excusrions in any W2 window shall not exceed 25MHz bandwidth and
    %magnitude <= 0.25 dB beyond spec

    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=15.04 && freqin(ii)<=15.34
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.4;
    RPL2=0.6;
    GS=0.3;
    dBMHz=0.035;
    exc=0.25;
    band='Ku N-CDL OL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;

end

if (KU_NCDL_IL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 25MHz with
    %magnitude of <= 0.25 dB beyond spec
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=14.54 && freqin(ii)<=14.79
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.4;
    RPL2=0.7;
    GS=0.4;
    dBMHz=0.055;
    exc=0.25;
    band='Ku N-CDL IL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;

end

if (X_Rx_CDL_RL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 45MHz in bandwidth
    %and 0.5 dB in mag beyond spec
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=10.15 && freqin(ii)<=10.45
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.6;
    RPL2=0.8;
    exc=0.5;
    GS=0.4;
    dBMHz=0.1;
    band='X-CDL RL';
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;


end
if (X_Tx_CDL_FL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 10MHz bandwidth
    %with magnitude of 0.2 dB beyond spec
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=9.75 && freqin(ii)<=9.95
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            freq2(iii)=freqin2(ii);
            AMP2(iii)=AMPY2(ii);
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.4;
    RPL2=0.6;
    GS=0.3;
    dBMHz=0.08;
    exc=0.2;
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
                
            else if rem(fc(ii),freq(iii))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
                    indfc=iii;
                else
                end
            end
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
    AVV=zeros(L,1);
    fDV=zeros(L,1);
    vi=1;
    for v=indfmin:indfmax
        AVV(vi)=AMP(v);
        fDV(vi)=freq(v);
        AVV2(vi)=AMP(v);
        fDV2(vi)=freq(v);
        vi=vi+1;
    end

    SLA=polyfit(freq,AMP,1);  % this section makes a straight line approximation across the passband
    SLA2=polyfit(freq,AMP2,1);
    for viii=1:nfreq
        AMPSLA(viii)=(SLA(1)*freq(viii))+SLA(2);
        AMPSLA2(viii)=(SLA(1)*freq(viii))+SLA2(2);
    end

    for ix=1:nfreq  %this normalizes the data to the straight line approximation
        peacemaker(ix)=AMP(ix)+(max(AMPSLA)-AMPSLA(ix));
        peacemakerSLA(ix)=AMPSLA(ix)+(max(AMPSLA)-AMPSLA(ix));
        peacemaker2(ix)=AMP2(ix)+(max(AMPSLA2)-AMPSLA2(ix));
        peacemakerSLA2(ix)=AMPSLA2(ix)+(max(AMPSLA2)-AMPSLA2(ix));
    end
    PMAVV=zeros(L,1);
    PMfDV=zeros(L,1);
    PMAVV2=zeros(L,1);
    PMfDV2=zeros(L,1);
    x=1;
    for v=indfmin:indfmax
        PMAVV(x)=peacemaker(v);
        PMfDV(x)=freq(v);
        PMAVV2(x)=peacemaker2(v);
        PMfDV2(x)=freq2(v);
        x=x+1;
    end
    
    [w1MaxVar(ii),w2MaxVar(ii)]=MaxAmpVar(PMfDV,PMAVV,lengthw1);
    [w1MaxVar2(ii),w2MaxVar2(ii)]=MaxAmpVar(PMfDV2,PMAVV2,lengthw1);
    
    if movie==1
        F2(ii)=getframe; %this gets frame for the optional movie
        F2avi=addframe(F2avi,F2(ii));%Builds the movie file
    end
   
     countmonger=countmonger+1
end

%Plot the Maxiumu W1 ripple values across the band.

if exc==0
    VarSpecYw1=[RPL1;RPL1];
    VarSpecXw1=[0;length(w1MaxVar)];
    fstart=fcmin-(W1/2);
    fend=fcmax+(W1/2);
    fstep=(fend-fstart)/(length(w1MaxVar)-1);

    figure(7)
    clf
    figure(7)
    alpha(spec_alpha);
    hold on;
    subplot(2,1,1)
    plot(VarSpecXw1,VarSpecYw1,'g',1:length(w1MaxVar),w1MaxVar,':b',1:length(w1MaxVar),w1MaxVar2,'-.m','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W1 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps','fontsize',12);
    ylabel({'Amplitude (dB)',['(Max Var = ',num2str(max(w1MaxVar),2),')']},'fontsize',12);
    axis([1 length(w1MaxVar) 0 RPL1+.2+exc])
    legend('Specified Variation','SN 005 Data','IRAD 2 Data','Location','Best')
    grid on

    VarSpecYw2=[RPL2;RPL2];
    %Plot the Maximum W2 Ripple across the band
    VarSpecXw2=[0;length(w2MaxVar)];
    flength=length(freq);
    
    fstart=freq(1);
    fend=freq(flength);
    fstep=(fend-fstart)/(length(w2MaxVar)-1);
    alpha(spec_alpha);
    subplot(2,1,2)
    plot(VarSpecXw2,VarSpecYw2,'g',1:length(w2MaxVar),w2MaxVar,':b',1:length(w1MaxVar),w1MaxVar2,'-.m','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W2 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps','fontsize',12);
    ylabel({'Amplitude (dB)',['(Max Var = ',num2str(max(w2MaxVar),2),')']},'fontsize',12);
    axis([1 length(w2MaxVar) 0 RPL2+exc+.2])
    legend('Specified Variation','SN 005 Data','IRAD 2 Data','Location','Best')
    grid on
    hold off
else
    VarSpecYw1=[RPL1;RPL1];
    VarExcYw1=[RPL1+exc;RPL1+exc];
    VarSpecXw1=[0;length(w1MaxVar)];
    fstart=fcmin-(W1/2);
    fend=fcmax+(W1/2);
    fstep=(fend-fstart)/(length(w1MaxVar)-1);

    figure(1)
    clf
    figure(1)
    alpha(spec_alpha);
    hold on;
    subplot(2,1,1)
    plot(VarSpecXw1,VarSpecYw1,'g',VarSpecXw1,VarExcYw1,'--r',1:length(w1MaxVar),w1MaxVar,':b',1:length(w1MaxVar),w1MaxVar2,'-.m','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W1 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps','fontsize',12);
    ylabel({'Amplitude (dB)',['(Max Var = ',num2str(max(w1MaxVar),2),')']},'fontsize',12);
    axis([1 length(w1MaxVar) 0 RPL1+.2+exc])
    legend('Specified Variation','Allowed Excursion','SN 005 Data','IRAD 2 Data','Location','Best')
    grid on

    %Plot the Maximum W2 Ripple across the band
    VarSpecYw2=[RPL2;RPL2];
    VarExcYw2=[RPL2+exc;RPL2+exc];
    VarSpecXw2=[0;length(w2MaxVar)];
    flength=length(freq);
    fstart=freq(1);
    fend=freq(flength);
    fstep=(fend-fstart)/(length(w2MaxVar)-1);

    alpha(spec_alpha);
    hold on;
    subplot(2,1,2)
    plot(VarSpecXw2,VarSpecYw2,'g',VarSpecXw2,VarExcYw2,'--r',1:length(w2MaxVar),w2MaxVar,':b',1:length(w1MaxVar),w1MaxVar2,'-.m','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W2 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps','fontsize',12);
    ylabel({'Amplitude (dB)',['(Max Var = ',num2str(max(w2MaxVar),2),')']},'fontsize',12);
    axis([1 length(w2MaxVar) 0 RPL2+exc+.2])
    legend('Specified Variation','Allowed Excursion','SN 005 Data','IRAD 2 Data','Location','Best')
    grid on
    hold off
end