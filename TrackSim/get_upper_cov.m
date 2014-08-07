function out=get_upper_cov(in)
[dummy,n]=size(in);
temp=reshape(1:n*n,n,n);
temp=triu(temp);
temp=temp(:);
temp=temp(temp~=0);
out=in(temp);