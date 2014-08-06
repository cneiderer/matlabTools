function [freq, S]=AMCBRENTREAD(file)
dat1 = load (file);
freq = dat1(:,1);
freq = freq/1e9;
S11R = dat1(:,2);%S11
S11I = dat1(:,3);
S21R = dat1(:,4);%S21
S21I = dat1(:,5);
S12R = dat1(:,6);%S12
S12I = dat1(:,7);
S22R = dat1(:,8);%S22
S22I = dat1(:,9);


S(:,1)=complex(S11R,S11I);
S(:,2)=complex(S21R,S21I);
S(:,3)=complex(S12R,S12I);
S(:,4)=complex(S22R,S22I);

