function RUV = rrc2ruv(RRC, T_RRC_RFC, d_RRC_RFC)
%     RUV = Rrc_ruv(RRC, T_RRC_RFC, d_RRC_RFC)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts vectors in RRC to RUV coordinates
%
%   Input:
%        RRC        --  state vectors in RRC (3XN, 6XN, or 9XN)
%        T_RRC_RFC  --  RRC to RFC transformation matrix
%        d_RRC_RFC  --  A vector of misalignment errors (3xN)
%
%   Output:
%        RUV        -- state vector in RUV coordinates (3XN, 6XN, or 9XN)
%                   
%   Required Functions:
%      Rrc_rfc
%      Rfc_ruv

RUV = rfc2ruv( rrc2rfc(T_RRC_RFC, d_RRC_RFC, RRC) );

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
