function [w1MaxVar,w2MaxVar,w3MaxVar]=MaxGDVar(fDV,GDV,lengthw1,lengthw2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function accepts a frequency array(fDV), group delay array (GDV) and
%the length of the w1, w2 and w3 bandwidths as inputs.  It then calculates the
%group delay variation (W1Var, W2Var, W3Var)for the W1, W2, and W3 specification
%specification windows across the entire measured data bandwidth.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Separate the portion of the group delay array that fits within W1 by
%using the length of the W1 and assigning the
%corresponding value from GDV to the w1GD array.

test_array(:,1)=fDV;
test_array(:,2)=GDV;
indfminw1=floor(length(fDV)/2-(lengthw1)/2);
indfmaxw1=indfminw1+lengthw1;

for i=indfminw1:1:indfmaxw1
    for ii=1:length(fDV)
        if test_array(i,1)==fDV(ii)
            w1GD(i-(indfminw1-1))=test_array(ii,2);
        else
        end
    end
end        

%Separate the portion of the group delay array that fits within W2 by
%using the length of the W2 and assigning the
%corresponding value from GDVto the w2GD array.

indfminw2=floor(length(fDV)/2-(lengthw2)/2);
indfmaxw2=indfminw2+lengthw2;

for i=indfminw2:1:indfmaxw2
    for ii=1:length(fDV)
        if test_array(i,1)==fDV(ii)
            w2GD(i-(indfminw2-1))=test_array(ii,2);
        else
        end
    end
end        

%find the max variation within w1 and w2
w1MaxVar=max(w1GD)-min(w1GD);
w2MaxVar=max(w2GD)-min(w2GD);
w3MaxVar=max(GDV)-min(GDV);


