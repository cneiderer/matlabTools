function J2 = J_rrc_ruv(sv_RUV, T_RRC_RFC)
%     J2 = J_rrc_ruv(sv_RUV, T_RRC_RFC)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the RRC to RUV Jacobian matrix.
%
%   Input:
%        sv_RUV     --  object state vector in RUV.  Must be either 6x1,
%                       7x1, or 10x1.
%        T_RRC_RFC  --  RRC to RFC transformation matrix
%
%   Output:
%        J2  --  RRC to RUV Jacobian matrix.  Result is either 6x6, 7x7, or
%                10x10, depending on the length of the state vector.
%                   
%   Required Functions:
%      NONE
%

[state_length, N] = size(sv_RUV);

if state_length < 6
   error(['J_rrc_ruv: state vector length is too small, ' num2str(state_length)]);
end

%Initialize the output
J2    = zeros( state_length, state_length, N );


R     = sv_RUV(1); 
U     = sv_RUV(2);
V     = sv_RUV(3);
W     = sqrt(1 - U^2 - V^2);

R_dot = sv_RUV(4);
U_dot = sv_RUV(5);
V_dot = sv_RUV(6);
W_dot = (-U * U_dot - V * V_dot) / W;

A = [U            V          W; 
     (1-U*U)/R   -U*V/R     -U*W/R; 
     -U*V/R      (1-V*V)/R  -V*W/R];
%
term21 = ( -2*R*U*U_dot - (1-U*U)*R_dot ) / R^2;
term22 = ( -R*( U*V_dot + V*U_dot ) + U*V*R_dot ) / R^2;
term23 = ( -R*( U*W_dot + W*U_dot ) + U*W*R_dot ) / R^2;

term31 = ( -R*( U*V_dot + V*U_dot ) + U*V*R_dot ) / R^2;
term32 = ( -2*R*V*V_dot - (1-V*V)*R_dot ) / R^2;
term33 = ( -R*( V*W_dot + W*V_dot ) + V*W*R_dot ) / R^2;

A_dot = ...
    [U_dot   V_dot   W_dot;
     term21  term22  term23;
     term31  term32  term33];
%
ZERO_MAT3 = zeros(3,3);

tmp1 = [A  ZERO_MAT3; A_dot  A];
tmp2 = [T_RRC_RFC  ZERO_MAT3; ZERO_MAT3  T_RRC_RFC];

J2(1:6, 1:6) = tmp1 * tmp2; % 6 by 6
%
 
%If 7state, populate the 7,7 term
if state_length == 7
    J2(7,7) = 1;
end

if state_length == 10
	J2(7,7)    = 1;
	J2(8,8)    = 1;
	J2(9,9)    = 1;
	J2(10,10)  = 1;
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
