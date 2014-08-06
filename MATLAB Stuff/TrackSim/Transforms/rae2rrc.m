function RRC=rae2rrc(RAE)
%
%	Input:	RAE	:= position vectors in R (m),AZ (deg),EL (deg) coordinates (m) (3xN)
%
%	Output:	RRC	:= position vector in RRC coordinates


deg_to_rad = (pi/180);

if (size(RAE,1)==3);
	RAE=RAE.*[ones(1,size(RAE,2));deg_to_rad*ones(2,size(RAE,2))];
	x_RRC=RAE(1,:).*cos(RAE(3,:)).*sin(RAE(2,:));
	y_RRC=RAE(1,:).*cos(RAE(3,:)).*cos(RAE(2,:));
	z_RRC=RAE(1,:).*sin(RAE(3,:));
	RRC=[x_RRC;y_RRC;z_RRC];
elseif (size(RAE,1)==6);
	RAE=RAE.*[ones(1,size(RAE,2));deg_to_rad*ones(2,size(RAE,2));ones(1,size(RAE,2));deg_to_rad*ones(2,size(RAE,2))];
	x_RRC=RAE(1,:).*cos(RAE(3,:)).*sin(RAE(2,:));
	y_RRC=RAE(1,:).*cos(RAE(3,:)).*cos(RAE(2,:));
	z_RRC=RAE(1,:).*sin(RAE(3,:));
	x_dot_RRC=RAE(4,:).*cos(RAE(3,:)).*sin(RAE(2,:))-RAE(1,:).*(RAE(6,:)).*sin(RAE(3,:)).*sin(RAE(2,:))+RAE(1,:).*RAE(5,:).*cos(RAE(3,:)).*cos(RAE(2,:));
	y_dot_RRC=RAE(4,:).*cos(RAE(3,:)).*cos(RAE(2,:))-RAE(1,:).*(RAE(6,:)).*sin(RAE(3,:)).*cos(RAE(2,:))-RAE(1,:).*RAE(5,:).*cos(RAE(3,:)).*sin(RAE(2,:));
	z_dot_RRC=RAE(4,:).*sin(RAE(3,:))+RAE(1,:).*(RAE(6,:)).*cos(RAE(3,:));
	RRC=[x_RRC;y_RRC;z_RRC;x_dot_RRC;y_dot_RRC;z_dot_RRC];
else
	error('Error in RAE_RRC: incorrectly dimensioned input!!!');
end;

