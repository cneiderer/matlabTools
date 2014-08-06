function [y]=Q(x)

% Q.m
%

x=x';
y=0.5*erfc(x/sqrt(2));

x1=[0:0.1:10]';
y1=0.5*erfc(x1/sqrt(2));

x2=[0:-0.1:-10]';
y2=0.5*erfc(x2/sqrt(2));

z=1-y1;