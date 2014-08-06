function FSTEGroupDelaySpec = FSTEGroupDelaySpec
% This file reads in data from a text file, specified below, that contains
% frequency in GHz and group delay in seconds and applies the Fixed STE
% Group Delay Specs, chosen with the flags
clear all;
spec_alpha=0.5;
INTELSATRx    = 0; %toggles Rx option for intelsat
INTELSATTx    = 0; %toggles Tx option for Intelsat
Ku_CDL_FL     = 1; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
Ku_NCDL_Rx_OL = 0; %toggles Ku NCDL OL spec
Ku_NCDL_Tx_IL = 0; %toggles Ku NCDL OL spec
X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
X_Tx_CDL_FL   = 0; %Toggles X-Band CDL FL Spec
nstep         = 50; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
movie         = 0;  %Turns movie option on and off if = 1 the you get a movie if = 0 then you get to watch frame by frame and hit enter to move the window
GDSmoothie    = 140; %Smoothing factor for Group Delay Information
ylocdiff      = .8; %Moves the "Meets/Breaks spec" text in y so you can read it better

file='C:\SAT 1743 Data\05-06 Data\IRAD TX\15.195 RHCP MISMATCH.cti';

file2avi=strrep(file,'.cti','GDVAR.avi');
file4avi=strrep(file,'.cti','GDVARWdScr.avi');  
sn=('SN006')

%[freqin,Sp]=AMCBRENTREAD(file);%use this in case Brent sends you one of his special ".cti" files that really aren't .cti
[freqin,Sp]=Readcti(file);
freqin=freqin;
freqw=2*pi*freqin;
GDin=(Sp(:,2));
GDin2=unwrap(angle(GDin));
GDin3=smooth(GDin2,GDSmoothie); % This smooths out the phase data in order to keep it from being intolerably noisy from small changes in the phase line that cause the derivative to go apey
delw=freqw(3)-freqw(2);
GD=abs(diff(GDin3)/delw); %The - sign in front of this may need to be switched depending on how the data was taken


for ii=2:length(freqin)
    freq(ii-1)=freqin(ii);
end

GDoffset=min(GD(1000:2000));

if movie == 1
    F1avi=avifile(file2avi,'fps',5);%note if this filename already exists, it is going to puke.  
    %                                      %you have to either delete the
    %                                      exisiting file or change your
    %                                      filename.
    F2avi=avifile(file4avi,'fps',5);%note if this filename already exists, it is going to puke.  
    %                                      %you have to either delete the
    %                                      exisiting file or change your
    %                                      filename.
    
end


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

if (Ku_NCDL_Rx_OL)%Relaxed DONE
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
    band='N-CDL RX';
end

if (Ku_NCDL_Tx_IL)% Relax using this wording? : 
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
    band='N-CDL TX';
end

if (X_Rx_CDL_RL)% Relax DLY1 to 2.0 ns and Band Edge Spec to 25% of DLY3 and use following wording:
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

if (X_Tx_CDL_FL)% Relax DLY1 to 2.0ns and Band Edge Spec to 25% of DLY3  DONE
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
ii=1;
for ii=1:n
%     fmin=fc(ii)-W3/2;
    fmin=fc(ii)-W3/2;
    fmax=fc(ii)+W3/2;
    nfreq=length(freq);
    for iii=1:nfreq
        aa=rem(fmin,freq(iii));
        if rem(fmin,freq(iii))<=1 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmin=iii;
        else
            
        end
    end
    for iv=1:nfreq
        bb=rem(fmax,freq(iv));
        if rem(fmax,freq(iv))<=1 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmax=iv;
        else
            
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
    
    %find the index for the W2 start and end points and length of W2
        %find the index for the W1 start and end points
    fminw2=fc(ii)-W2/2;
    fmaxw2=fc(ii)+W2/2;
    iii=1;
    for iii=1:nfreq
        if rem(fminw2,freq(iii))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfminw2=iii;
        else

        end
    end
    iv=1;
    for iv=1:nfreq
        if rem(fmaxw2,freq(iv))<=0.005 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmaxw2=iv;
        else

        end
    end
    
    lengthw2=indfmaxw2-indfminw2;
    
    L=(indfmax-indfmin)+1;
    GDV=zeros(L,1);
    fDV=zeros(L,1);
    vi=1;
    for v=indfmin:indfmax
        GDV(vi)=GD(v)-GDoffset;
        fDV(vi)=freq(v);
        vi=vi+1;
    end
    GDVmin=min(GDV);
    specX1=[(fc(ii)-(W1/2));(fc(ii)-(W1/2));(fc(ii)+(W1/2));(fc(ii)+(W1/2));(fc(ii)-(W1/2))];
    specY1=[GDVmin;(GDVmin+DLY1);(GDVmin+DLY1);GDVmin;GDVmin];
    
    specX2=[(fc(ii)-(W2/2));(fc(ii)-(W2/2));(fc(ii)-(W1/2));(fc(ii)-(W1/2));(fc(ii)-(W2/2));(fc(ii)+(W2/2));(fc(ii)+(W2/2));(fc(ii)+(W1/2));(fc(ii)+(W1/2));(fc(ii)+(W2/2))];
    specY2=[GDVmin;(GDVmin+DLY2);(GDVmin+DLY2);GDVmin;GDVmin;GDVmin;(GDVmin+DLY2);(GDVmin+DLY2);GDVmin;GDVmin];
    
    specX3=[(fc(ii)-(W3/2));(fc(ii)-(W3/2));(fc(ii)-(W2/2));(fc(ii)-(W2/2));(fc(ii)-(W3/2));(fc(ii)+(W3/2));(fc(ii)+(W3/2));(fc(ii)+(W2/2));(fc(ii)+(W2/2));(fc(ii)+(W3/2))];
    specY3=[GDVmin;(GDVmin+DLY3);(GDVmin+DLY3);GDVmin;GDVmin;GDVmin;(GDVmin+DLY3);(GDVmin+DLY3);GDVmin;GDVmin];
    hold off;
    hold on;
    
    for iii=1:length(freq)
        if rem(fcmin-(W3/2),freq(iii))<=1
            indmin=iii;
        end
        if rem(fcmax+(W3/2),freq(iii))<=1
            indmax=iii;
        end
    end
    FMINNIE=freq(indmin);
    FMAXI=freq(indmax);
    GDVBE=abs(GD(indmin)-GD(indmax));
    GDVBES=GDVPERC*DLY3;
             
    ccbone1=rand(1,length(specX1)); %Makes all the pretty colors if you put these into
    ccbone2=rand(1,length(specX2)); %the color spot in fill funtion
    ccbone3=rand(1,length(specX3));
    
    count=count+1
    
    %Pick up the max variation w1, w2 and w3
    
    [w1MaxVar(ii),w2MaxVar(ii),w3MaxVar(ii)]=MaxGDVar(fDV,GDV,lengthw1,lengthw2);
    
    if movie==0
        R=input('Hit enter to see next window.');
    end
    
end
if movie==1         
    F1avi=close(F1avi)%Movie file close
    F2avi=close(F2avi) 
else
end

if exc==0
    VarSpecYw1=[DLY1;DLY1];
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
    plot(VarSpecXw1,VarSpecYw1,'g',1:length(w1MaxVar),w1MaxVar,':b','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W1 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps');
    ylabel({'Delay Var (nS)',['(Max Var = ',num2str(max(w1MaxVar),2),')']});
    if max(w1MaxVar)<=DLY1
        axis([1 length(w1MaxVar) 0 DLY1+.2])
    else
        axis([1 length(w1MaxVar) 0 max(w1MaxVar)+.2])
    end
    legend('Specified Variation','Measured Data')
    grid on

    VarSpecYw2=[DLY2;DLY2];
    %Plot the Maximum W2 Ripple across the band
    VarSpecXw2=[0;length(w2MaxVar)];
    flength=length(freq);
    fstart=freq(1);
    fend=freq(flength);
    fstep=(fend-fstart)/(length(w2MaxVar)-1);
    alpha(spec_alpha);
    subplot(2,1,2)
    plot(VarSpecXw2,VarSpecYw2,'g',1:length(w2MaxVar),w2MaxVar,':b','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W2 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps');
    ylabel({'Delay Var (nS)',['(Max Var = ',num2str(max(w2MaxVar),2),')']});
    
    if max(w2MaxVar)<=DLY2
        axis([1 length(w2MaxVar) 0 DLY2+.2])
    else
        axis([1 length(w2MaxVar) 0 max(w2MaxVar)+.2])
    end
    legend('Specified Variation','Measured Data')
    grid on
    hold off
    
    VarSpecYw3=[DLY3;DLY3];
    VarSpecXw3=[0;length(w3MaxVar)];
    fstart=fcmin-(W3/2);
    fend=fcmax+(W3/2);
    fstep=(fend-fstart)/(length(w3MaxVar)-1);

    figure(8)
    clf
    figure(8)
    alpha(spec_alpha);
    hold on;
    grid on
    plot(VarSpecXw3,VarSpecYw3,'g',1:length(w3MaxVar),w3MaxVar,':b','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W3 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps');
    ylabel({'Delay Var (nS)',['(Max Var = ',num2str(max(w3MaxVar),2),')']});
    if max(w3MaxVar)<=DLY3
        axis([1 length(w3MaxVar) 0 DLY3+.2])
    else
        axis([1 length(w3MaxVar) 0 max(w3MaxVar)+.2])
    end
    legend('Specified Variation','Measured Data')
    grid on
else
    VarSpecYw1=[DLY1;DLY1];
    VarExcYw1=[DLY1+exc;DLY1+exc];
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
    plot(VarSpecXw1,VarSpecYw1,'g',VarSpecXw1,VarExcYw1,'--r',1:length(w1MaxVar),w1MaxVar,':b','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W1 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps');
    ylabel({'Delay Var (nS)',['(Max Var = ',num2str(max(w1MaxVar),2),')']});
    axis([1 length(w1MaxVar) 0 DLY1+.2+exc])
    legend('Specified Variation','Allowed Excursion','Measured Data')
    grid on

    %Plot the Maximum W2 Ripple across the band
    VarSpecYw2=[DLY2;DLY2];
    VarExcYw2=[DLY2+exc;DLY2+exc];
    VarSpecXw2=[0;length(w2MaxVar)];
    flength=length(freq);
    fstart=freq(1);
    fend=freq(flength);
    fstep=(fend-fstart)/(length(w2MaxVar)-1);

    alpha(spec_alpha);
    hold on;
    subplot(2,1,2)
    plot(VarSpecXw2,VarSpecYw2,'g',VarSpecXw2,VarExcYw2,'--r',1:length(w2MaxVar),w2MaxVar,':b','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W2 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps');
    ylabel({'Delay Var (nS)',['(Max Var = ',num2str(max(w2MaxVar),2),')']});
    axis([1 length(w2MaxVar) 0 DLY2+exc+.2])
    legend('Specified Variation','Allowed Excursion','Measured Data')
    grid on
    
    figure(8)
    clf
    figure(8)
    alpha(spec_alpha);
    hold on;
    grid on
    plot(VarSpecXw3,VarSpecYw3,'g',1:length(w3MaxVar),w3MaxVar,':b','LineWidth',2.0)
    title([num2str(band),' Maximum Variation for any W3 window'],'fontsize',14,'fontweight','b');
    xlabel('# Window Steps');
    ylabel({'Delay Var (nS)',['(Max Var = ',num2str(max(w3MaxVar),2),')']});
    axis([1 length(w3MaxVar) 0 DLY3+.2+exc])
    legend('Specified Variation','Measured Data')
    hold off
end