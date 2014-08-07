function [SqrtposEigs,SqrtvelEigs]=getSQRTcovEigs(P)


%  Assume P is 6x6xN

[M,N,L]=size(P);

for ii=1:M
    SqrtposEigs(ii)=max(sqrt(eig(squeeze(P(ii,1:3,1:3)))));
    SqrtvelEigs(ii)=max(sqrt(eig(squeeze(P(ii,4:6,4:6)))));
end
    
