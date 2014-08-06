% DIPIMP   Provides the input impedances ZIN and feeding current IIN
%          for dipole array placed side by side.  
%
%          [ZIN, IIN] = DIPIMP(D,L,V,TYPE)
%
%          D  is elements spacing vector,  L  is the element  length 
%          vector, A  is  the  element radius and  V  is the feeding 
%          voltage vector. The  size  of  D must  be  the  number of 
%          elements minus one.  All dimensions have to be normalized
%          by the operating wavelength  and voltage must be provided
%          in volts. Finally, TYPE is 1 for dipoles parallel to each
%          other and 2 for collinear dipoles. 

% RFWave - The Radio Frequency Wave Toolbox
% Version: 1.2 16-Jul-2002
% Developed by A. C. de C. Lima 
% E-mail: acdcl@ufba.br
% Electrical Engineering Department
% Federal University of Bahia (UFBA)
% Brazil

function [zin, iin] = dipimp(d,ld,a,vd,type)

n=length(ld);
k=2*pi;
c=0.5772;
zo=120*pi;

z=zeros(n);
mm=1;
% Mutual and proper impedances Zij
for ii=1:n-1
    dr=0;
    for ij=ii:n 
        if ii == ij
            l=ld(ii);
            kl=k*l; 
	        ci1=ci(kl);
	        ci2=ci(2*kl);
	        ci3=ci(4*pi*a^2/l);
	        si1=si(kl);
	        si2=si(2*kl);
	        rr=c+log(kl)-ci1+0.5*sin(kl)*(si2-2*si1);
	        rr=60*(rr+0.5*cos(kl)*(c+log(kl/2)+ci2-2*ci1));
	        aux=2*si1+cos(kl)*(2*si1-si2);
	        xm=30*(aux-sin(kl)*(2*ci1-ci2-ci3));
	        rin=rr/sin(kl/2)^2;
	        xin=xm/sin(kl/2)^2;
	        zp=rin+j*xin;
            z(ii,ij)=zp;
        else
            dr=dr+d(ij-1);
            l1=ld(ii);
	        l2=ld(ij);
            z(ii,ij)=mutimp(dr,l1,l2,type);
            z(ij,ii)=z(ii,ij);
        end
    end
end
l=ld(n);
kl=2*pi*l;
ci1=ci(kl);
ci2=ci(2*kl);
ci3=ci(4*pi*a^2/l);
si1=si(kl);
si2=si(2*kl);
rr=c+log(kl)-ci1+0.5*sin(kl)*(si2-2*si1);
rr=60*(rr+0.5*cos(kl)*(c+log(kl/2)+ci2-2*ci1));
aux=2*si1+cos(kl)*(2*si1-si2);
xm=30*(aux-sin(kl)*(2*ci1-ci2-ci3));
rin=rr/sin(kl/2)^2;
xin=xm/sin(kl/2)^2;
zp=rin+j*xin;
z(n,n)=zp;

% Input currents and impedances 
iin=inv(z)*conj(vd');
iin=conj(iin');
zin=vd./iin;
