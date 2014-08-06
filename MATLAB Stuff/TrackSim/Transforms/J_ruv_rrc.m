function J_RUV_RRC = J_ruv_rrc(state_RUV, T_rrc_rfc)
%     J_RUV_RRC = J_ruv_rrc(state_RUV, T_rrc_rfc)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the RUV to RRC Jacobian matrix, used to convert
%      covariance matricies from RUV to RRC.
%
%   Input:
%        state_RUV  --  object state vector in RUV (6x1)
%        T_rrc_rfc  --  RRC to RFC transformation matrix
%
%   Output:
%        J_RUV_RRC  --  RUV to RRC Jacobian matrix
%                   
%   Required Functions:
%      None.

R = state_RUV(1); 
U = state_RUV(2); 
V = state_RUV(3);
W = sqrt(1 - U^2 - V^2);

R_dot = state_RUV(4);
U_dot = state_RUV(5);
V_dot = state_RUV(6);
W_dot = (-U * U_dot - V * V_dot) / W;

A_inv     = zeros(3,3);
A_inv_dot = zeros(3,3);

A_inv(1,1) = U;
A_inv(1,2) = R;
A_inv(2,1) = V;
A_inv(2,3) = R;
A_inv(3,1) = W;
A_inv(3,2) = -U * R / W;
A_inv(3,3) = -V * R / W;

A_inv_dot(1,1) = U_dot;
A_inv_dot(1,2) = R_dot;
A_inv_dot(2,1) = V_dot;
A_inv_dot(2,3) = R_dot;
A_inv_dot(3,1) = W_dot;
A_inv_dot(3,2) = (-W * (U * R_dot + U_dot * R) + U * R * W_dot) / W^2;
A_inv_dot(3,3) = (-W * (V * R_dot + V_dot * R) + V * R * W_dot) / W^2;

mat1 = [T_rrc_rfc' zeros(3,3);
        zeros(3,3) T_rrc_rfc'];
mat2 = [A_inv zeros(3,3);
        A_inv_dot A_inv];

J_RUV_RRC = mat1 * mat2;

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
