function [truth]=propacc(truth,radar,sv0)

t0=0;
if ~exist('sv0','var')
    sv0=truth.RRC(:,1);
end
tFinal=600;
deltaT=1;

t=[t0:deltaT:tFinal]';
sv=zeros(length(t),6);
a=zeros(length(t),3);

sv(1,:)=sv0;
alpha=zeros(length(sv),1);


m_start_i=10;
m_stop_i=130;
Isp=2100;
alpha_0=16;   
alpha(m_start_i:m_stop_i)=1./((1/alpha_0)-(t(m_start_i:m_stop_i)-t(m_start_i))/Isp);

m_start_i=200;
m_stop_i=300;
Isp=2100;
alpha_0=16;   
alpha(m_start_i:m_stop_i)=1./((1/alpha_0)-(t(m_start_i:m_stop_i)-t(m_start_i))/Isp);

m_start_i=300;
m_stop_i=320;
Isp=3000;
alpha_0=6;   
alpha(m_start_i:m_stop_i)=alpha_0;

m_start_i=400;
m_stop_i=550;
Isp=3000;
alpha_0=20;   
alpha(m_start_i:m_stop_i)=alpha_0;

% [acc_grav, acc_cor, acc_cen] = Acceleration(truth.RRC(1:3,ii)+radar.site.r0_rrc,truth.RRC(4:6,ii), constants, radar);
%     truth.residial_acc(ii)=norm(truth.a_rrc(:,ii) - acc_grav - acc_cor - acc_cen);

theta_i=0;
theta_c=0;

for indx=2:length(t)

r_pos        = sv(indx-1,1:3)';
vel          = sv(indx-1,4:6)';
    %Unit vectors in the "V" frame
e1 = Unit(vel, 1);
e2 = Cross3(r_pos, vel, 1);
e3 = Cross3(e1, e2, 1);

%Calculate the thrust acceleration, in RRC
a(indx-1,:)     = alpha(indx-1) .* ...
    ( cos(theta_i) * ( cos(theta_c) .* e1 + sin(theta_c) .* e2 ) + ...
        sin(theta_i) .* e3 );
%



    dt=t(indx)-t(indx-1);
    PHI=[eye(3) dt*eye(3)
        zeros(3) eye(3)];
    sv(indx,:)=(PHI*(sv(indx-1,:)'))'+[a(indx-1,:)*dt^2/2 a(indx-1,:)*dt];
end



truth=[];
truth.time=t.';
truth.RRC=sv.';
truth.RUV=rrc2ruv( truth.RRC,  radar.site.fs, radar.site.d_RRC_RFC);
truth.a_rrc=a.';

figure; plot(t,alpha);






