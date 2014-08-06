% function FSTEGroupDelaySpec = FSTEGroupDelaySpec
function [window_bounds] = GroupDelay_Spec_Single_SN_Plot(varargin)

% This file reads in data from a text file, specified below, that contains
% frequency in GHz and group delay in seconds and applies the Fixed STE
% Group Delay Specs, chosen with the flags

sn='SN004';
spec_alpha=0.5;
INTELSATRx    = 0; %toggles Rx option for intelsat
INTELSATTx    = 0; %toggles Tx option for Intelsat
Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
Ku_NCDL_Rx_OL = 0; %toggles Ku NCDL OL spec (15.04 to 15.34)
Ku_NCDL_Tx_IL = 0; %toggles Ku NCDL OL spec (14.54 to 14.79)
X_Rx_CDL_RL   = 0; %toggles X-Band CDL RL Spec
X_Tx_CDL_FL   = 0; %Toggles X-Band CDL FL Spec
nstep         = 25; %defines the number of frequency steps you wish to move the window over inside the frequency band of interest.
movie         = 0;  %Turns movie option on and off if = 1 the you get a movie if = 0 then you get to watch frame by frame and hit enter to move the window
GDSmoothie    = 140; %Smoothing factor for Group Delay Information
ylocdiff      = .8; %Moves the "Meets/Breaks spec" text in y so you can read it better

% file='C:\SAT 1743 Data\System\SN001\Final 12-3-08\10.30_RX_LH.cti';

if nargin==1
    file=varargin{1};
else
    [filename,filepath]=uigetfile('*.cti','Select the file for analysis: ')
    file=fullfile(filepath,filename);
end

% Find Band
switch 1
    case ~isempty(strfind(file,'14.615')) % Ku-CDL RL
        Ku_CDL_RL=1;
    case ~isempty(strfind(file,'15.25')) % Ku-CDL FL
        Ku_CDL_FL=1;
    case ~isempty(strfind(file,'10.3')) % X-CDL RL
        X_Rx_CDL_RL=1;
    case ~isempty(strfind(file,'15.19')) % N-CDL OL
        KU_NCDL_OL=1;
    case ~isempty(strfind(file,'14.665')) % N-CDL IL
        KU_NCDL_IL=1;
    case ~isempty(strfind(file,'11.85')) % Intelsat DL
        INTELSATRx=1;
    case ~isempty(strfind(file,'9.85')) % X-CDL FL
        X_Tx_CDL_FL=1;
    case ~isempty(strfind(file,'14.125')) % Intelsat UL
        INTELSATTx=1;
    otherwise
        disp('Frequency band could not be determined from the file name')
end

file2avi=strrep(file,'.cti','GDVAR.avi');
file4avi=strrep(file,'.cti','GDVARWdScr.avi');  
% sn=('SN006')

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


figure(111)

plot(freq,GD-GDoffset,'r')
title('GD of SN006,')
ylabel('nsec')
xlabel('Frequency (GHz)')
legend('SN006 (Final)')
grid on;


figure(45)
hold on;
plot(freq,GD,'r')
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
%     fmin=fc(ii)-W3/2;
    fmin=fc(ii)-W3/2;
    fmax=fc(ii)+W3/2;
    nfreq=length(freq);
    for iii=1:nfreq
        aa=rem(fmin,freq(iii));
        if rem(fmin,freq(iii))<=0.5 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmin=iii;
        else
            
        end
    end
    for iv=1:nfreq
        bb=rem(fmax,freq(iv));
        if rem(fmax,freq(iv))<=0.5 %note this limit may need adjustment depending on the frequency steps of the measurement
            indfmax=iv;
        else
            
        end
    end

%     nfreq=length(freq);
%     for iii=1:nfreq
%         if fmin-freq(iii)==0
%             indfmin=iii;
%         else
%         end
%         if fmax-freq(iii)==0
%             indfmax=iii;
%         else
%         end
%     end
    
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
    
    % Calculate W1 polygon vertices
    specX1=[(fc(ii)-(W1/2));(fc(ii)-(W1/2));(fc(ii)+(W1/2));(fc(ii)+(W1/2));...
        (fc(ii)-(W1/2))];
    specY1=[GDVmin;(GDVmin+DLY1);(GDVmin+DLY1);GDVmin;GDVmin];
    
    % Calculate W2 polygon vertices
    specX2=[(fc(ii)-(W2/2));(fc(ii)-(W2/2));(fc(ii)-(W1/2));(fc(ii)-(W1/2));...
        (fc(ii)-(W2/2));(fc(ii)+(W2/2));(fc(ii)+(W2/2));(fc(ii)+(W1/2));...
        (fc(ii)+(W1/2));(fc(ii)+(W2/2))];
    specY2=[GDVmin;(GDVmin+DLY2);(GDVmin+DLY2);GDVmin;GDVmin;GDVmin;...
        (GDVmin+DLY2);(GDVmin+DLY2);GDVmin;GDVmin];
    
    % Calculate W3 polygon vertices
    specX3=[(fc(ii)-(W3/2));(fc(ii)-(W3/2));(fc(ii)-(W2/2));(fc(ii)-(W2/2));...
        (fc(ii)-(W3/2));(fc(ii)+(W3/2));(fc(ii)+(W3/2));(fc(ii)+(W2/2));...
        (fc(ii)+(W2/2));(fc(ii)+(W3/2))];
    specY3=[GDVmin;(GDVmin+DLY3);(GDVmin+DLY3);GDVmin;GDVmin;GDVmin;...
        (GDVmin+DLY3);(GDVmin+DLY3);GDVmin;GDVmin];
    
%%%%% ---------- %% Group Delay Excursions %% ---------- %%%%%
    
    %% Find window boundaries
    % Find W1 window boundaries
    window_bounds(ii).W1.minfreq=round2(fc(ii)-(W1/2),3);
    window_bounds(ii).W1.maxfreq=round2(fc(ii)+(W1/2),3);
    window_bounds(ii).W1.GDmin=GDVmin;
    window_bounds(ii).W1.GDmax=GDVmin+DLY1;

    % Find W2 window boundaries
    window_bounds(ii).W2.minfreq1=round2((fc(ii)-(W2/2)),3);
    window_bounds(ii).W2.maxfreq1=round2((fc(ii)-(W1/2)),3);
    window_bounds(ii).W2.GDmin=GDVmin;
    window_bounds(ii).W2.GDmax=GDVmin+DLY2;
    window_bounds(ii).W2.minfreq2=round2((fc(ii)+(W1/2)),3);
    window_bounds(ii).W2.maxfreq2=round2((fc(ii)+(W2/2)),3);

    % Find W3 window boundaries
    window_bounds(ii).W3.minfreq1=round2((fc(ii)-(W3/2)),3);
    window_bounds(ii).W3.maxfreq1=round2((fc(ii)-(W2/2)),3);
    window_bounds(ii).W3.GDmin=GDVmin;
    window_bounds(ii).W3.GDmax=GDVmin+DLY3;
    window_bounds(ii).W3.minfreq2=round2((fc(ii)+(W2/2)),3);
    window_bounds(ii).W3.maxfreq2=round2((fc(ii)+(W3/2)),3);

    %% Find signal pieces
    window_bounds(ii).W1.freqindx=[]; window_bounds(ii).W1.freqpts=[];
    window_bounds(ii).W2.freqindx1=[]; window_bounds(ii).W2.freqpts1=[];
    window_bounds(ii).W2.freqindx2=[]; window_bounds(ii).W2.freqpts2=[];
    window_bounds(ii).W3.freqindx1=[]; window_bounds(ii).W3.freqpts1=[];
    window_bounds(ii).W3.freqindx2=[]; window_bounds(ii).W3.freqpts2=[];
    for jj=1:length(fDV)
        freqpt=round2(fDV(jj),3); % Round freqpt to 4 decimal places
        % W1
        if freqpt>window_bounds(ii).W1.minfreq && ...
                freqpt<window_bounds(ii).W1.maxfreq
            window_bounds(ii).W1.freqindx(end+1)=jj;
            window_bounds(ii).W1.freqpts(end+1)=freqpt;
            % W2
        elseif freqpt>window_bounds(ii).W2.minfreq1 && ...
                freqpt<=window_bounds(ii).W2.maxfreq1
            window_bounds(ii).W2.freqindx1(end+1)=jj;
        elseif freqpt>=window_bounds(ii).W2.minfreq2 && ...
                freqpt<window_bounds(ii).W2.maxfreq2
            window_bounds(ii).W2.freqindx2(end+1)=jj;
            % W3
        elseif freqpt>=window_bounds(ii).W3.minfreq1 && ...
                freqpt<=window_bounds(ii).W3.maxfreq1
            window_bounds(ii).W3.freqindx1(end+1)=jj;
        elseif freqpt>=window_bounds(ii).W3.minfreq2 && ...
                freqpt<=window_bounds(ii).W3.maxfreq2
            window_bounds(ii).W3.freqindx2(end+1)=jj;
        else
            error(['Frequency point: ',num2str(freqpt),...
                ' did not fit in any windows'])
        end
    end
    window_bounds(ii).W1.measvals=GDV(window_bounds(ii).W1.freqindx);
    window_bounds(ii).W2.measvals1=GDV(window_bounds(ii).W2.freqindx1);
    window_bounds(ii).W2.measvals2=GDV(window_bounds(ii).W2.freqindx2);
    window_bounds(ii).W3.measvals1=GDV(window_bounds(ii).W3.freqindx1);
    window_bounds(ii).W3.measvals2=GDV(window_bounds(ii).W3.freqindx2);

    %% Check for excursions; Measure excursions when necessary
    % W1 excursions
    excursion_exist=...
        excursion_test(window_bounds(ii).W1.GDmin,window_bounds(ii).W1.GDmax,...
        window_bounds(ii).W1.measvals);
    if excursion_exist==true
        excursion_details=...
            measure_excursions(window_bounds(ii).W1.GDmin,window_bounds(ii).W1.GDmax,...
            window_bounds(ii).W1.freqindx,window_bounds(ii).W1.freqpts,...
            window_bounds(ii).W1.measvals,band);
        window_bounds(ii).W1.excursions=excursion_details;
    else
        window_bounds(ii).W1.excursions_exist='None';
    end
    % W2 excursions
    excursion_exist=...
        excursion_test(window_bounds(ii).W2.GDmin,window_bounds(ii).W2.GDmax,...
        window_bounds(ii).W2.measvals1);
    if excursion_exist==true
        excursion_details=...
            measure_excursions(window_bounds(ii).W2.GDmin,window_bounds(ii).W2.GDmax,...
            window_bounds(ii).W2.freqindx,window_bounds(ii).W2.freqpts1,...
            window_bounds(ii).W2.measvals1,band);
        window_bounds(ii).W2.excursions1=excursion_details;
    else
        window_bounds(ii).W2.excursions1='None';
    end
    excursion_exist=...
        excursion_test(window_bounds(ii).W2.GDmin,window_bounds(ii).W2.GDmax,...
        window_bounds(ii).W2.measvals2);
    if excursion_exist==true
        excursion_details=...
            measure_excursions(window_bounds(ii).W2.GDmin,window_bounds(ii).W2.GDmax,...
            window_bounds(ii).W2.freqindx,window_bounds(ii).W2.freqpts2,...
            window_bounds(ii).W2.measvals2,band);
        window_bounds(ii).W2.excursions2=excursion_details;
    else
        window_bounds(ii).W2.excursions2='None';
    end
    % W3 excursions
    excursion_exist=...
        excursion_test(window_bounds(ii).W3.GDmin,window_bounds(ii).W3.GDmax,...
        window_bounds(ii).W3.measvals1);
    if excursion_exist==true
        excursion_details=...
            measure_excursions(window_bounds(ii).W2.GDmin,window_bounds(ii).W2.GDmax,...
            window_bounds(ii).W2.freqindx,window_bounds(ii).W2.freqpts1,...
            window_bounds(ii).W2.measvals1,band);
        window_bounds(ii).W3.excursions1=excursion_details;
    else
        window_bounds(ii).W3.excursions1='None';
    end
    excursion_exist=...
        excursion_test(window_bounds(ii).W3.GDmin,window_bounds(ii).W3.GDmax,...
        window_bounds(ii).W3.measvals2);
    if excursion_exist==true
        excursion_details=...
            measure_excursions(window_bounds(ii).W3.GDmin,window_bounds(ii).W2.GDmax,...
            window_bounds(ii).W3.freqindx,window_bounds(ii).W3.freqpts2,...
            window_bounds(ii).W3.measvals2,band);
        window_bounds(ii).W3.excursions2=excursion_details;
    else
        window_bounds(ii).W3.excursions2='None';
    end
    
%%%%%%%%%%    
    
    hold off;
    hold on;
    
    for ii=1:length(freq)
        if rem(fcmin-(W3/2),freq(ii))<=1
            indmin=ii;
        end
        if rem(fcmax+(W3/2),freq(ii))<=1
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
    
    if movie==0
%         R=input('Hit enter to see next window.');
        
        % Continue or break loop
        if ~exist('R','var') || isempty(R) 
            continue;
        else
            disp('Loop has been broken, script will now terminate')
            broken=1;
            break;
        end
    end

    if movie==1
        F2(ii)=getframe; %this gets frame for the optional movie
        F2avi=addframe(F2avi,F2(ii));%Builds the movie file
    end

    
end


if movie==1
    F1avi=close(F1avi)%Movie file close
    F2avi=close(F2avi)
end


%%%%% ---------- %% Sub-Functions %% ---------- %%%%%

%% excursion_test.m
function excursion_exist=excursion_test(minGD,maxGD,measurements)

if (max(measurements)-min(measurements)) > (maxGD-minGD)
    excursion_exist=true;
else
    excursion_exist=false;
end

%% measure_excursions.m
function excursion_details=...
    measure_excursions(minGD,maxGD,freqindx,freqpts,measurements,band)

excursion_details.amp=(max(measurements)-min(measurements))-(maxGD-minGD);

% Find pts where measured vals cross spec vals
maxpts=sign(maxGD-measurements);
% minpts=sign(measurements-minGD);

excursion_indx=[];
for kk=1:length(maxpts)
    if maxpts(kk)<0 && ~exist('start_indx','var')
        if kk~=1
            start_indx=kk-1;
        else
            start_indx=kk;
        end
        excursion_indx=[excursion_indx;kk];
    elseif maxpts(kk)<0
        excursion_indx=[excursion_indx;kk];
    elseif maxpts(kk)>=0 && exist('start_indx','var') &&...
           ~exist('end_indx','var')
        end_indx=kk;
    elseif maxpts(kk)>=0
end

excursion_details.BW=freqpts(end_indx)-freqpts(start_indx);
excursion_details.startfreq=freqpts(start_indx);
excursion_details.endfreq=freqpts(end_indx);
excursion_details.units.freq='GHz';
excursion_details.units.time='ns';

% Create excursion polygon vertices
excursion_details.vertices.Xcoord=[freqpts(start_indx),freqpts(start_indx),...
    freqpts(end_indx),freqpts(end_indx),freqpts(start_indx)];
excursion_details.vertices.Ycoord=[measurements(start_indx),...
    measurements(start_indx),measurements(end_indx),measurements(end_indx),...
    measurements(start_indx)];

% Excursion Pass/Fail Test
% X-STD_CDL-RL(RX)
if (strcmpi(band,'X CDL RX')) && ...
   ((excursion_details.amp<=(1*10^-9)) && (excursion_details.BW*10^3)<=25)
    excursion_details.passed_spec=true;
% Ku_NCDL-IL(TX)
elseif (strcmpi(band,'N-CDL TX')) && ...
       ((excursion_details.amp<=(1*10^-9)) && (excursion_details.BW*10^3)<=30)
    excursion_details.passed_spec=true;
else
    excursion_details.passed_spec=false;
end
