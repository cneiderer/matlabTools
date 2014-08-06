function [indx]=untitled(HFSS_Sdata)

for ii=1:length(HFSS_Sdata.freq)
    if round2(HFSS_Sdata.freq(ii),3)==9.325
        indx=ii;
    end
end