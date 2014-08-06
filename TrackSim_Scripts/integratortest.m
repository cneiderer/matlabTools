function [truth2]= integratortest(data,t_pend)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ---------- UNCLASSIFIED ---------- %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% Inputs
%   data
%   t_pend  ->  upper time boundary
%
% Outputs
%   truth2
%

[constants radar truth] = initialize_tracker(data);
start_indx=find(truth.time>=278.5,1,'first');
sv0=truth.RRC(1:6,start_indx);
t0=truth.time(start_indx);

y0=[sv0(1:3);
    sv0(4:6)];

options=[];
options.RelTol=1e-14;
options.AbsTol=1e-14;

[t_out,sv_out]=ode45('accelFunction',[t0 t_pend],y0,options,constants,radar);

t_all=[truth.time(1:start_indx-1) t_out.'].';
sv_all=[truth.RRC(:,1:start_indx-1) sv_out.'].';


svinterp=interp1(t_all,sv_all,truth.time(1):.2:t_pend);
truth2=struct;
truth2.time=truth.time(1):.2:t_pend;
truth2.RRC=zeros(6,length(truth2.time));
truth2.RRC(1:3,:)=svinterp(:,1:3).';
truth2.RRC(4:6,:)=svinterp(:,4:6).';
truth2.RUV=rrc2ruv( truth2.RRC,  radar.site.fs, radar.site.d_RRC_RFC);

[constants radar truth_dontuse] = initialize_tracker(data);
truth2.a_rrc=[diff(truth2.RRC(4:6,:).')./repmat(diff(truth2.time.'),1,3)].';
truth2.a_rrc=[ [0 0 0].' , truth2.a_rrc];
for ii=1:length(truth2.time)
    [acc_grav, acc_cor, acc_cen] = ...
    Acceleration(truth2.RRC(1:3,ii)+radar.site.r0_rrc,truth2.RRC(4:6,ii), constants, radar);
    truth2.residial_acc(ii)=norm(truth2.a_rrc(:,ii) - acc_grav - acc_cor - acc_cen);
end

figure; 
plot(truth2.time,truth2.residial_acc);

