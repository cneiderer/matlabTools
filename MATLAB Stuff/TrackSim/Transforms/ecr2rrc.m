function RRC = ecr2rrc(ECR, T_ECR_RRC, R_ECR_0)
%
%     RRC = Ecr_rrc(ECR, T_ECR_RRC, R_ECR_0)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts vectors in ECR to RRC coordinates
%
%   Input:
%        ECR        --  state vectors in ECR (3XN, 6XN, or 9XN)
%        T_ECR_RRC  --  RRC to RFC transformation matrix
%        R_ECR_0    --  A vector of misalignment errors (3xN)
%
%   Output:
%        RRC        -- state vector in RRC coordinates (3XN, 6XN, or 9XN)
%                   
%   Required Functions:
%      none
%

[m_ECR, n_ECR] = size(ECR);

if m_ECR == 3
	RRC = T_ECR_RRC *( ECR - R_ECR_0 * ones(1,n_ECR));
elseif m_ECR == 6
	RRC = [ T_ECR_RRC * (ECR(1:3,:) - R_ECR_0 * ones(1,n_ECR)); ...
			T_ECR_RRC * (ECR(4:6,:))];
elseif m_ECR == 9
	RRC = [ T_ECR_RRC * (ECR(1:3,:) - R_ECR_0 * ones(1,n_ECR)); ...
      T_ECR_RRC * (ECR(4:6,:)); ...
			T_ECR_RRC*(ECR(7:9,:))];
else
	error('ECR_RRC: incorrectly dimensioned input!!!');
end;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
