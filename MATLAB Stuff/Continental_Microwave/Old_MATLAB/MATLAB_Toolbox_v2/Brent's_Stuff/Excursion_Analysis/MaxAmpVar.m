function [w1MaxVar,w2MaxVar]=MaxAmpVar(PMfDV,PMAVV,lengthw1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function accepts a frequency array(PMfDV), amplitude array (PMAVV) and
%specification window array (PMspecX1) an inputs.  It then calculates the amplitude
%variation (W1Var) for the W1 specification window across the entire
%measured data bandwidth.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Separate the portion of the amplitude array that fits within W1 by
%comparing values in PMfDV with values of PMspecX1 and assigning the
%corresponding value from PMAVV to the w1amp array.

test_array(:,1)=PMfDV;
test_array(:,2)=PMAVV;
indfminw1=floor(length(PMfDV)/2-(lengthw1)/2);
indfmaxw1=indfminw1+lengthw1;

for i=indfminw1:1:indfmaxw1
    for ii=1:length(PMfDV)
        if test_array(i,1)==PMfDV(ii)
            w1amp(i-(indfminw1-1))=test_array(ii,2);
        else
        end
    end
end        

%find the max variation within w1 and w2
w1MaxVar=max(w1amp)-min(w1amp);

w2MaxVar=max(PMAVV)-min(PMAVV);


