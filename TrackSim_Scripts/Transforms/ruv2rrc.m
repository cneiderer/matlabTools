function RRC = ruv2rrc(RUV, T_RRC_RFC, d_RRC_RFC)
%     RRC = Ruv_rrc(RUV, T_RRC_RFC, d_RRC_RFC)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts vectors in RUV coordinates to RRC
%
%   Input:
%        RUV        --  state vectors in RUV (3XN, 6XN, or 9XN)
%        T_RRC_RFC  --  RRC to RFC transformation matrix
%        d_RRC_RFC  --  A vector of misalignment errors (3xN)
%
%   Output:
%        RRC        -- state vector in RRC coordinates (3XN, 6XN, or 9XN)
%                   
%   Required Functions:
%      Rfc_rrc  --  
%      Ruv_rfc  --  
%

[m_RUV, n_RUV] = size(RUV);

if (m_RUV==3 || m_RUV==6 || m_RUV==9);
	RRC = rfc2rrc( T_RRC_RFC, d_RRC_RFC, ruv2rfc(RUV) );
else
	error('RUV_RRC: incorrectly dimensioned input!!!');
end;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
