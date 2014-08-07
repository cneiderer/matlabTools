function out=put_upper_cov(in)
m=length(in);
n=(sqrt(9+8*m)-3)/2;
outtemp=zeros(n,n);
temp=reshape(1:n*n,n,n);
temp=triu(temp);
temp=temp(:);
temp=temp(temp~=0);
outtemp(temp)=in(n+1:end);
out=triu(outtemp,1)+triu(outtemp,1)'+diag(diag(outtemp));
