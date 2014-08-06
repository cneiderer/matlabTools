function [MaxS11, FreqMaxS11, MaxS22, FreqMaxS22] = vswr_spec_analysis(file)
% This file reads in data from the .cti file that contains
% frequency in GHz, and the [RE, IM] S-parameter data.
% It then calculates and returns the max values for S11
% and S22 in VSWR format.  

INTELSATRx    = 0; %toggles Rx option for intelsat
INTELSATTx    = 0; %toggles Tx option for Intelsat
Ku_CDL_FL     = 0; %toggles Ku FL CDL spec
Ku_CDL_RL     = 0; %toggles Ku RL CDL spec
Ku_NCDL_OL    = 0; %toggles Ku NCDL OL spec (15.04-15.34)
Ku_NCDL_IL    = 0; %toggles Ku NCDL IL spec (14.54-14.79)
X_CDL_RL      = 0; %toggles X-Band CDL RL Spec
X_CDL_FL      = 0; %Toggles X-Band CDL FL Spec

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

s11in=(Sin(:,1));
s22in=(Sin(:,4));


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
    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=13.75 && freqin(ii)<=14.5
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end
if (INTELSATRx)%relax and with wording DONE
    %Total excursions in any W2 window shall not exceed 40 MHz in bandwidth with magnitude
    %<= 0.4 dB beyond spec
    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=10.95 && freqin(ii)<=12.75
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end



if (Ku_CDL_FL)%Relaxed and with wording DONE
    %Total excursions in any W2 window shall not exceed 20 MHz in bandwidth
    %with magnitude <=0.2 dB beyond spec constraint
    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=15.25 && freqin(ii)<=15.35
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end

if (Ku_CDL_RL)%Relax and with wording DONE
    %Total excursions in any W2 window shall not exceed 20 MHz bandwidth
    %with magnitude <=0.2 dB beyond spec

    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=14.4 && freqin(ii)<=14.83
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end
    
if (Ku_NCDL_OL)%Relax DONE
    %Total excusrions in any W2 window shall not exceed 25MHz bandwidth and
    %magnitude <= 0.25 dB beyond spec

    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=15.04 && freqin(ii)<=15.34
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end

if (Ku_NCDL_IL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 25MHz with
    %magnitude of <= 0.25 dB beyond spec
    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=14.54 && freqin(ii)<=14.79
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end

if (X_CDL_RL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 45MHz in bandwidth
    %and 0.5 dB in mag beyond spec
    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=10.15 && freqin(ii)<=10.45
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end

if (X_CDL_FL)%Relax with wording DONE
    %Total excursions in any W2 window shall not exceed 10MHz bandwidth
    %with magnitude of 0.2 dB beyond spec
    %Set up the frequency array for the desired band.
    iii=1;
    for ii=1:length(freqin)
        if freqin(ii)>=9.75 && freqin(ii)<=9.95
            freq(iii)=freqin(ii);
            S11(iii)=s11in(ii);
            S22(iii)=s22in(ii);
            iii=iii+1;
        end
    end
end

s11_mag=abs(S11);
s11_vswr=(1.+s11_mag)./(1.-s11_mag);
s22_mag=abs(S22);
s22_vswr=(1.+s22_mag)./(1.-s22_mag);

[MaxS11,FreqMaxS11ind]=max(s11_vswr);
[MaxS22,FreqMaxS22ind]=max(s22_vswr);
FreqMaxS11=freq(FreqMaxS11ind);
FreqMaxS22=freq(FreqMaxS22ind);
