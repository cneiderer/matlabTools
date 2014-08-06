function FSTEGroupDelaySpec = FSTEGroupDelaySpec
% This file reads in data from a text file, specified below, that contains
% frequency in GHz and group delay in seconds and applies the Fixed STE
% Group Delay Specs, chosen with the flags
clear all;
spec_alpha=0.5;
INTELSATRx    = 0; %toggles Rx option for intelsat
INTELSATTx    = 0; %toggles Tx option for Intelsat
Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
Ku_NCDL_Rx_OL = 0; %toggles Ku NCDL OL spec
Ku_NCDL_Tx_IL = 0; %toggles Ku NCDL OL spec
X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
X_Tx_CDL_FL   = 1; %Toggles X-Band CDL FL Spec
nstep         = 10; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
movie         = 0;  %Turns movie option on and off if = 1 the you get a movie if = 0 then you get to watch frame by frame and hit enter to move the window
GDSmoothie    = 130; %Smoothing factor for Group Delay Information
GDSmoothie2    = 120; %Smoothing factor for Group Delay Information for second file
GDSmoothie3    = 120; %Smoothing factor for Group Delay Information for 3rd file
ylocdiff      = .8; %Moves the "Meets/Breaks spec" text in y so you can read it better

file='E:\9.85 TX LHCP.cti';
file2='E:\9.85 TX LHCP.cti';
file3='E:\9.85 TX LHCP.cti';
file2avi=strrep(file,'.cti','GDVAR.avi');
file4avi=strrep(file,'.cti','GDVARWdScr.avi');  
sn=('SN005')

%[freqin,Sp]=AMCBRENTREAD(file);%use this in case Brent sends you one of his special ".cti" files that really aren't .cti
[freqin,Sp]=Readcti(file);
freqin=freqin;
freqw=2*pi*freqin;
GDin=(Sp(:,2));
GDin2=unwrap(angle(GDin));
GDin3=smooth(GDin2,GDSmoothie); % This smooths out the phase data in order to keep it from being intolerably noisy from small changes in the phase line that cause the derivative to go apey
delw=freqw(2)-freqw(1);
GD=abs(diff(GDin3)/delw); %The - sign in front of this may need to be switched depending on how the data was taken

[freqin2,Sp2]=Readcti(file2);
freqin2=freqin2;
freqw2=2*pi*freqin2;
GDin2=(Sp2(:,2));
GDin22=unwrap(angle(GDin2));
GDin32=smooth(GDin22,GDSmoothie2); % This smooths out the phase data in order to keep it from being intolerably noisy from small changes in the phase line that cause the derivative to go apey
delw2=freqw2(2)-freqw2(1);
GD2=abs(diff(GDin32)/delw2); %The - sign in front of this may need to be switched depending on how the data was taken

[freqin3,Sp3]=Readcti(file3);
freqin3=freqin3;
freqw3=2*pi*freqin3;
GDin3=(Sp3(:,2));
GDin23=unwrap(angle(GDin3));
GDin33=smooth(GDin23,GDSmoothie3); % This smooths out the phase data in order to keep it from being intolerably noisy from small changes in the phase line that cause the derivative to go apey
delw3=freqw3(2)-freqw3(1);
GD3=-abs(diff(GDin33)/delw3); %The - sign in front of this may need to be switched depending on how the data was taken



for ii=2:length(freqin)
    freq(ii-1)=freqin(ii);
end

for ii=2:length(freqin2)
    freq2(ii-1)=freqin2(ii);
end

for ii=2:length(freqin3)
    freq3(ii-1)=freqin3(ii);
end

GDoffset=min(GD(1000:2000));
GD2offset=min(GD2(1000:2000));
GD3offset=min(GD3(1000:2000));

figure(111)
%plot(freq,GD-GDoffset,'r',freq2,GD2-GD2offset,'b',freq3,GD3-GD3offset,'m')% You may have to change the offset on GD and or GD2 to get them on the same level
plot(freq,GD-GDoffset,'r',freq3,GD3-GD3offset,'b')% only plots 2
%title(['GD comparison of SN2 SN3 SN4  ',plotnamer2])
title('GD comparison of SN005, SN002 (1/2 system)')
ylabel('nsec')
xlabel('Frequency (GHz)')
legend('SN005 (Final)','SN002 (1/2 system)')
grid on;


figure(45)
hold on;
plot(freq,GD,'b')
title('Smoothing Progress');
grid on



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
    fcmin=9.75+(W3/2);
    fcmax=9.95-(W3/2);
    fcspan=fcmax-fcmin;
    fcdelta=(fcspan)/(nstep);
    fc=fcmin:fcdelta:fcmax;
    band='X CDL TX';
end


n=length(fc);
for ii=1:n
    fmin=fc(ii)-W3/2;
    fmax=fc(ii)+W3/2;
    nfreq=length(freq);
    for iii=1:nfreq
        if rem(fmin,freq(iii))<=0.008 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmin=iii;
        else
            
        end
    end
    for iv=1:nfreq
        if rem(fmax,freq(iv))<=0.008 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmax=iv;
        else
            
        end
    end
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
    
    for ii=1:length(freq)
        if rem(fcmin-(W3/2),freq(ii))<=0.0009
            indmin=ii;
        end
        if rem(fcmax+(W3/2),freq(ii))<=0.00008
            indmax=ii;
        end
    end
    FMINNIE=freq(indmin)
    FMAXI=freq(indmax)
    GDVBE=abs(GD(indmin)-GD(indmax));
    GDVBES=GDVPERC*DLY3;
             
    ccbone1=rand(1,length(specX1)); %Makes all the pretty colors if you put these into
    ccbone2=rand(1,length(specX2)); %the color spot in fill funtion
    ccbone3=rand(1,length(specX3));
    
    figure(1)    
    cla
    figure(1)
    H = fill(specX1,specY1,'g',specX2,specY2,'y',specX3,specY3,'r');
    set(H,'EdgeColor','none')    
    alpha(spec_alpha);
    hold on;
    plot(fDV,GDV,'b','LineWidth',2.0)
    xlabel('Frequency (GHz)');
    ylabel('Group Delay (nS)');
    title({'Group Delay vs. Frequency Spec Window';band;sn});
    grid on;
    if movie==1
        F1(ii)=getframe; %this gets frame for the optional movie
        F1avi=addframe(F1avi,F1(ii));%Builds the movie file
    end
    if movie==0
        %R=input('Hit enter to see next window.');
    end
    
    figure(2)    
    cla
    figure(2)
    H = fill(specX1,specY1,'g',specX2,specY2,'y',specX3,specY3,'r');
    set(H,'EdgeColor','none') 
    alpha(spec_alpha);
    hold on;
    plot(freq,GD-GDoffset,'b','LineWidth',2.0)
    title({'Group Delay vs. Frequency whole band';band;sn});
    xlabel('Frequency (GHz)');
    ylabel('Group Delay (nS)');
    if GDVBE >GDVBES
        ywords=max(specY3);
        xwords=min(freq)+((max(freq)-min(freq))/2);
        text(freq(indmin),GD(indmin),['GDLBE: ',num2str(GD(indmin)),'ns'],'VerticalAlignment','bottom','fontweight','bold')
        text(freq(indmax),GD(indmax),['GDHBE:',num2str(GD(indmax)),'ns'],'VerticalAlignment','bottom','Horizontal','right','fontweight','bold')
        text(xwords,(ywords+ylocdiff),['Diff @ band edges: ',num2str(GDVBE),'ns'],'VerticalAlignment','bottom','fontweight','bold')
        text(xwords,(ywords+ylocdiff),['Out of SPEC: <=',num2str(GDVBES),'ns :('],'VerticalAlignment','top','fontweight','bold')
        %legend(['Difference between band edges: ',num2str(GDVBE),'ns'],['OUT OF SPEC: <=',num2str(GDVBES),'ns :('])
    end
    if GDVBE<=GDVBES
        ywords=max(specY3);
        xwords=min(freq)+((max(freq)-min(freq))/2);
        text(freq(indmin),GD(indmin),['GDLBE: ',num2str(GD(indmin)),'ns'],'VerticalAlignment','bottom','fontweight','bold')
        text(freq(indmax),GD(indmax),['GDHBE:',num2str(GD(indmax)),'ns'],'VerticalAlignment','bottom','Horizontal','right','fontweight','bold')
        text(xwords,(ywords+ylocdiff),['Diff @ band edges: ',num2str(GDVBE),'ns'],'VerticalAlignment','bottom','fontweight','bold')
        text(xwords,(ywords+ylocdiff),['MEETS SPEC: <=',num2str(GDVBES),'ns :)'],'VerticalAlignment','top','fontweight','bold')
    end
    grid on;
    if movie==1
        F2(ii)=getframe; %this gets frame for the optional movie
        F2avi=addframe(F2avi,F2(ii));%Builds the movie file
    end
    if movie==0
        R=input('Hit enter to see next window.');
    end
    
end
if movie==1
    F1avi=close(F1avi)%Movie file close
    F2avi=close(F2avi)
end

