
Ke=12.56*10^6;
Z0=50;
Ze=69.4;
center_freq=1*10^9;
theta=60;
b=30;
d=12;

K12=9.75*10^6;
K45=9.75*10^6;
K23=6.82*10^6;
K34=6.82*10^6;

K=K12;

S_mm=(b/1.37)*[(0.91*(d/b))+0.1529-...
    log10(((((2*deg2rad(theta))/(sin(2*deg2rad(theta))))+1)*K)/center_freq)]
S_in=S_mm*(1/10)*(1/2.54)


T_in=asin(sqrt((Z0*Ke*((0.5*sin(2*deg2rad(theta)))+...
    deg2rad(theta)))/((center_freq*Ze)))
T_mm=T_in*((2.54/1)*(10/1))


C=159.16/(tan(deg2rad(theta))*center_freq*Ze)

