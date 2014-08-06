function [freq, S21LM]=ReadMarkFile(file)
dat1 = xlsread (file);
freq = dat1(:,1);
freq = freq/1e9;
S21LM = dat1(:,2);%S21


