function RRC = rfc2rrc(T_RRC_RFC,d_RRC_RFC,RFC);
%
%	Converts RFC to RRC. If T_RRC_RFC is 3X3N, then the RFC is assumed
%	to be rotating relative to RRC.
%
%	Inputs:	
%		T_RRC_RFC	:=	RRC to RFC transformation matrix; (3X3N)
%		d_RRC_RFC	:=	vector between RRC and RFC origins
%		RFC		:=	position vector in RFC; (3XN), (6XN), or (9XN)
%
%	Output:
%		RRC		:= position vectors in RRC coordinates; (3XN), (6XN), or (9XN)
%
[m_RFC,n_RFC]=size(RFC);
[m_T_RRC_RFC,n_T_RRC_RFC]=size(T_RRC_RFC);

if n_T_RRC_RFC < 3;
	error('RRC_RFC: T_RRC_RFC has less than 3 columns!!!');
end;

if n_T_RRC_RFC==3;
	if m_RFC==3;
		RRC = T_RRC_RFC'*RFC+d_RRC_RFC*ones(1,n_RFC);
	elseif m_RFC==6;
		RRC = [T_RRC_RFC'*RFC(1:3,:)+d_RRC_RFC*ones(1,n_RFC);T_RRC_RFC'*RFC(4:6,:)];
	elseif m_RFC==9;
    		RRC = [T_RRC_RFC'*RFC(1:3,:)+d_RRC_RFC*ones(1,n_RFC);T_RRC_RFC'*RFC(4:6,:);T_RRC_RFC'*RFC(7:9,:)];
	else
		error('RFC_RRC: incorrectly dimensioned input!!!');
	end;
elseif mod(n_T_RRC_RFC,3)==0;
	row_1=zeros(3,n_T_RRC_RFC/3);
	row_2=zeros(3,n_T_RRC_RFC/3);
	row_3=zeros(3,n_T_RRC_RFC/3);
	row_1(:)=T_RRC_RFC(:,[1:3:end]);
	row_2(:)=T_RRC_RFC(:,[2:3:end]);
	row_3(:)=T_RRC_RFC(:,[3:3:end]);
	T_RFC_RRC=[row_1(:)';row_2(:)';row_3(:)'];
	if m_RFC==3;
		RFC_pos=RFC(1:3,:);
		% inclusion of d_RRC_RFC may not be correct!!!
		RRC=[	T_RFC_RRC.*(ones(3,1)*RFC_pos(:)'+d_RRC_RFC*ones(1,3*n_RFC))]*kron(eye(n_RFC),ones(3,1));
	elseif m_RFC==6;
%		error('RFC_RRC not yet developed for [pos;vel] conversion!!!');      
		RFC_pos=RFC(1:3,:);
		RFC_vel=RFC(4:6,:);
		RRC=[	T_RFC_RRC.*(ones(3,1)*RFC_pos(:)');
				T_RFC_RRC.*(ones(3,1)*RFC_vel(:)')]*kron(eye(n_RFC),ones(3,1));
	elseif m_RFC==9;
%		error('RFC_RRC not yet developed for [pos;vel;acc] conversion!!!');      
		RFC_pos=RFC(1:3,:);
		RFC_vel=RFC(4:6,:);
		RFC_acc=RFC(7:9,:);
		RRC=[	T_RFC_RRC.*(ones(3,1)*RFC_pos(:)');
				T_RFC_RRC.*(ones(3,1)*RFC_vel(:)');
 				T_RFC_RRC.*(ones(3,1)*RFC_acc(:)')]*kron(eye(n_RFC),ones(3,1));
	else
		error('RFC_RRC: incorrectly dimensioned input!!!');
	end;         
else
	error('RRC_RFC: T_RFC_RRC has a number of columns not a multiple of 3!!!');
end;
