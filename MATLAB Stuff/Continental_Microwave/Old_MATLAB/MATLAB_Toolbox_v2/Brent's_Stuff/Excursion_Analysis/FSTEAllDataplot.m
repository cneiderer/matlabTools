function FSTEAMPVARSpec = FSTEAMPVARSpec
% This file reads in data from two .cti file that contains
% frequency in GHz and Magnitude in dB and applies the Fixed STE
% Amplitude Variation Specs, chosen with the flags
% Pay attention to the smoothing variables, they can change your outcome
% dramatically.  

spec_alpha=0.5;
INTELSATRx    = 0; %toggles Rx option for intelsat
INTELSATTx    = 1; %toggles Tx option for Intelsat
Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
Ku_NCDL_Rx_OL = 0; %toggles Ku NCDL OL spec
Ku_NCDL_Tx_IL = 0; %toggles Ku NCDL OL spec
X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
X_Tx_CDL_FL   = 0; %Toggles X-Band CDL FL Spec
nstep         = 100; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
movie         = 0;  %Turns movie option on and off if = 1 the you get a movie if = 0 then you get to watch frame by frame and hit enter to move the window
dBpMHzSMTHFCT = 50; %Smoothing factor for dB/MHz spec section, must be interger greater than 1
AMPYSMTH      = 30; %Smoothing factor for input Amplitude data,must be interger greater than 1


file='C:\MR-T RFE Data\SN010_FINAL_TEST\TX\14.125.cti';
file2avi=strrep(file,'.cti','.avi');
file4avi=strrep(file,'.cti','WdScr.avi');
plotnamer1=strrep(file,'C:\Data\Jobs\MRTCDL\AMC FIXED STE\',' ');
plotnamer2=strrep(plotnamer1,'_SN4.cti',' ');


%[freqin,Sin]=AMCBRENTREAD(file);%use this in case Brent sends you one of his special ".cti" files that really aren't .cti
%[freqin,AMPY]=ReadMarkFile(file);%use this to read AMC Excel files with freq,
%LM data
[freqin,Sin]=Readcti(file);

%freq=freqin;
%Comment next 3 lines if using ReadMarkFile
AMPin=(Sin(:,2));
AMPindB=20*log10(abs(AMPin)); %Puts data into dB
AMPY=smooth(AMPindB,AMPYSMTH); %Smooths the data from the cut if needed.
%AMPY=AMPindB;


figure(111)
AMPYNORM=max(AMPY);

plot(freqin,AMPY-AMPYNORM,'r')
title('Normalized AMP of SN006 (Final Config)')
ylabel('dB')
xlabel('Frequency (GHz)')
legend('SN006 Full System')
grid on;


if (INTELSATTx)%Relaxed DONE
    iii=1;
    for ii=1:length(freqin)
            freq(iii)=freqin(ii);
            AMP(iii)=AMPY(ii);
            iii=iii+1;
    end
    W1=0.040;
    W2=0.070;
    RPL1=0.65;
    RPL2=0.85;
    GS=0.6;
    dBMHz=0.03;
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
    GS=1.1;
    dBMHz=0.03;
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
    GS=0.3;
    dBMHz=0.055;
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
    GS=0.75;
    dBMHz=0.06;
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
end
  
    

    
if (Ku_NCDL_Rx_OL)%Relax DONE
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
    GS=0.3;
    dBMHz=0.035;
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;

end

if (Ku_NCDL_Tx_IL)%Relax with wording DONE
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
    GS=0.4;
    dBMHz=0.055;
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
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.6;
    RPL2=0.8;
    GS=0.4;
    dBMHz=0.1;
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
            iii=iii+1;
        end
    end
    W1=0.075;
    W2=0.150;
    RPL1=0.4;
    RPL2=0.6;
    GS=0.3;
    dBMHz=0.08;
    fcmin=min(freq)+(W2/2);
    fcmax=max(freq)-(W2/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;


end
    

countmonger=1;

if movie==1
    F2avi=avifile(file2avi,'fps',5);%note if this filename already exists, it is going to puke.
    %you have to either delete the exisiting file or change your filename.
    F4avi=avifile(file4avi,'fps',5);%note if this filename already exists, it is going to puke.
    %you have to either delete the exisiting file or change your filename.
end
n=length(fc);
for ii=1:n
    fmin=fc(ii)-W2/2;
    fmax=fc(ii)+W2/2;
    nfreq=length(freq);
    for iii=1:nfreq
        if rem(fmin,freq(iii))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmin=iii;
        else

        end
    end
    for iv=1:nfreq
        if rem(fmax,freq(iv))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmax=iv;
        else

        end
    end
    for vii=1:nfreq
        if rem(fc(ii),freq(vii))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfc=vii;
        else

        end
    end

    L=(indfmax-indfmin)+1;
    AVV=zeros(L,1);
    fDV=zeros(L,1);
    vi=1;
    for v=indfmin:indfmax
        AVV(vi)=AMP(v);
        fDV(vi)=freq(v);
        vi=vi+1;
    end
    Meany=mean(AVV);

    specX1=[(fc(ii)-(W1/2));(fc(ii)-(W1/2));(fc(ii)+(W1/2));(fc(ii)+(W1/2));(fc(ii)-(W1/2))];
    specY1=[(Meany-(RPL1/2));(Meany+(RPL1/2));(Meany+(RPL1/2));(Meany-(RPL1/2));(Meany-(RPL1/2))];

    specX2=[(fc(ii)-(W2/2));(fc(ii)-(W2/2));(fc(ii)-(W1/2));(fc(ii)-(W1/2));(fc(ii)-(W2/2));...
        (fc(ii)+(W2/2));(fc(ii)+(W2/2));(fc(ii)+(W1/2));(fc(ii)+(W1/2));(fc(ii)+(W2/2))];
    specY2=[(Meany-(RPL2/2));(Meany+(RPL2/2));(Meany+(RPL2/2));(Meany-(RPL2/2));(Meany-(RPL2/2));...
        (Meany-(RPL2/2));(Meany+(RPL2/2));(Meany+(RPL2/2));(Meany-(RPL2/2));(Meany-(RPL2/2))];


    SLA=polyfit(freq,AMP,1);  % this section makes a straight line approximation across the passband
    for viii=1:nfreq
        AMPSLA(viii)=(SLA(1)*freq(viii))+SLA(2);
    end

    for ix=1:nfreq  %this normalizes the data to the straight line approximation
        peacemaker(ix)=AMP(ix)+(max(AMPSLA)-AMPSLA(ix));
        peacemakerSLA(ix)=AMPSLA(ix)+(max(AMPSLA)-AMPSLA(ix));
    end
    PMAVV=zeros(L,1);
    PMfDV=zeros(L,1);
    x=1;
    for v=indfmin:indfmax
        PMAVV(x)=peacemaker(v);
        PMfDV(x)=freq(v);
        x=x+1;
    end
    PMmeany=mean(PMAVV);
    PMspecX1=[(fc(ii)-(W1/2));(fc(ii)-(W1/2));(fc(ii)+(W1/2));(fc(ii)+(W1/2));(fc(ii)-(W1/2))];

    PMspecX2=[(fc(ii)-(W2/2));(fc(ii)-(W2/2));(fc(ii)-(W1/2));(fc(ii)-(W1/2));(fc(ii)-(W2/2));...
        (fc(ii)+(W2/2));(fc(ii)+(W2/2));(fc(ii)+(W1/2));(fc(ii)+(W1/2));(fc(ii)+(W2/2))];

    PMspecY1=[(PMmeany-(RPL1/2));(PMmeany+(RPL1/2));(PMmeany+(RPL1/2));(PMmeany-(RPL1/2));(PMmeany-(RPL1/2))];

    PMspecY2=[(PMmeany-(RPL2/2));(PMmeany+(RPL2/2));(PMmeany+(RPL2/2));(PMmeany-(RPL2/2));(PMmeany-(RPL2/2));...
        (PMmeany-(RPL2/2));(PMmeany+(RPL2/2));(PMmeany+(RPL2/2));(PMmeany-(RPL2/2));(PMmeany-(RPL2/2))];
    
        
        
        
    figure(3)
    cla
    figure(3)
    ccbone=-rand(1,length(specX1));
    ccbone2=-rand(1,length(specX2));
    H = fill(specX1,specY1,ccbone,specX2,specY2,ccbone2);
    set(H,'EdgeColor','none')
    alpha(spec_alpha);
    hold on;
    plot(fDV,AVV,'w','LineWidth',2.0)
    xlabel('Frequency (GHz)');
    ylabel('Amplitude (dB)');
    title(['Amplitude vs. Frequency Spec Window fc = ',num2str(fc(ii)),' GHz']);
    grid on;


    GSspecX=[(min(freq));(min(freq));(max(freq));(max(freq));(min(freq))];
    GSspecY=[(min(AMPSLA));(min(AMPSLA)+GS);(min(AMPSLA)+GS);(min(AMPSLA));(min(AMPSLA))];
    cc=rand(1,length(GSspecX));
    figure(4)
    cla
    figure(4)
    H = fill(GSspecX,GSspecY,'y');
    set(H,'EdgeColor','none')
    alpha(spec_alpha);
    hold on;
    plot(freq,AMP,'b','LineWidth',2.0)
    plot(freq,AMPSLA,'Color','w','LineWidth',2.0)
    title(['Straight Line Approximation vs. Frequency Shows Gain Slope fc = ',num2str(fc(ii)),' GHz']);
    xlabel('Frequency (GHz)');
    ylabel('Amplitude (dB)');

    DGS=max(AMPSLA)-min(AMPSLA); %Data Gain slope from straight line approximation
    if DGS>GS
%         text(freq(1),AMPSLA(1),['Gain Slope = ',num2str(DGS),'dB'],'VerticalAlignment','bottom','fontweight','bold')
%         text(freq(1),AMPSLA(1),['Exceeds SPEC : ',num2str(GS),'dB :('],'VerticalAlignment','top','fontweight','bold')
          text(freq(1),min(AMP),['Gain Slope = ',num2str(DGS),'dB'],'VerticalAlignment','bottom','fontweight','bold')
          text(freq(1),min(AMP),['Exceeds SPEC : ',num2str(GS),'dB :('],'VerticalAlignment','top','fontweight','bold')
    end
    if DGS<=GS
        text(freq(1),max(GSspecY),['Gain Slope = ',num2str(DGS),'dB NOTE:Slope is slope of SLA'],'VerticalAlignment','bottom','fontweight','bold')
        text(freq(1),max(GSspecY),['Meets SPEC : ',num2str(GS),'dB :)'],'VerticalAlignment','top','fontweight','bold')
    end
    grid on;
    
    figure(5)
    cla
    figure(5)
    H = fill(specX1,specY1,ccbone,specX2,specY2,ccbone2);
    set(H,'EdgeColor','none')
    alpha(spec_alpha);
    hold on;
    plot(freq,AMP,'Color','b','LineWidth',2.0)
    title(['Amplitude vs. Frequency whole band fc = ',num2str(fc(ii)),' GHz']);
    xlabel('Frequency (GHz)');
    ylabel('Amplitude (dB)');
    grid on;
    if movie==1
        F4(ii)=getframe; %this gets frame for the optional movie
        F4avi=addframe(F4avi,F4(ii));%Builds the movie file
    end


    figure(6)
    cla
    figure(6)
    PMccbone=rand(1,length(specX1));
    PMccbone2=rand(1,length(specX2));
    H = fill(PMspecX1,PMspecY1,'m',PMspecX2,PMspecY2,'g');
    set(H,'EdgeColor','none')
    alpha(spec_alpha);
    hold on;
    plot(PMfDV,PMAVV,'b','LineWidth',2.0)
    xlabel('Frequency (GHz)');
    ylabel('Amplitude (dB)');
    title(['Amplitude vs. Frequency Spec Window Normalized to SLA fc = ',num2str(fc(ii)),' GHz']);
    grid on;
    if movie==1
        F2(ii)=getframe; %this gets frame for the optional movie
        F2avi=addframe(F2avi,F2(ii));%Builds the movie file
    end
    
    %%%%%%%%%%%%%%%%%%dB/MHz spec section%%%%%%%%%%%%%%%%%%%%%%%


    freqMHz=freq*1000;
    delfMHz=freqMHz(2)-freqMHz(1);
    dBperMHz=(diff(AMP)/delfMHz);
    for xxx=2:length(freqMHz)
        freqMHzplot(xxx-1)=freqMHz(xxx)/1000;
    end
    dBsmoothie=smooth(dBperMHz,dBpMHzSMTHFCT); %This smoothing may need to be adjusted to make this make sense maybe leave a bit of noise on it to be sure the overall trace is not greatly changed
    
    figure(7)
    cla
    figure(7)
    plot(freqMHzplot,dBsmoothie)
    grid on;
    title('dB/MHz spec plot')
    xlabel('Freq (GHz)')
    ylabel('dB/MHz')
    midplot = min(freqMHzplot)+((max(freqMHzplot)-min(freqMHzplot))/2);
    if abs(max(dBsmoothie))<=dBMHz && abs(min(dBsmoothie))<=dBMHz
        dBMHzmax=max(dBsmoothie);
        dBMHzmin=min(dBsmoothie);
        if abs(dBMHzmax)>abs(dBMHzmin)
            dBMHzval=abs(dBMHzmax);
        else
            dBMHzval=abs(dBMHzmin);
        end
        text(midplot,(dBMHzmax-(dBMHzmax/2)),['Max dB/MHz: ',num2str(dBMHzval),'dB'],'VerticalAlignment','bottom','fontweight','bold')
        text(midplot,(dBMHzmax-(dBMHzmax/2)),['MET SPEC: ',num2str(dBMHz),'dB :)'],'VerticalAlignment','top','fontweight','bold')
    elseif abs(max(dBsmoothie))>=dBMHz || abs(min(dBsmoothie))>=dBMHz
        dBMHzmax= max(dBsmoothie);
        dBMHzmin= min(dBsmoothie);
        if abs(dBMHzmax)>abs(dBMHzmin)
            dBMHzval=abs(dBMHzmax);
        else
            dBMHzval=abs(dBMHzmin);
        end
        text(midplot,(dBMHzmin-(dBMHzmin/2)),['Max dB/MHz: ',num2str(dBMHzval),'dB'],'VerticalAlignment','bottom','fontweight','bold')
        text(midplot,(dBMHzmin-(dBMHzmin/2)),['BROKE SPEC: ',num2str(dBMHz),'dB :('],'VerticalAlignment','top','fontweight','bold')

    end
    
    if movie==0
        R=input('Hit (or gently press depending on your mood) ENTER to continue to next Frequency Window.');
        countmonger=countmonger+1
    end

end

if movie==1
    F2avi=close(F2avi)%Movie file close
    F4avi=close(F4avi)%Movie file close
end

