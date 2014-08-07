function RUV = rfc2ruv(RFC)
%     RUV = Rfc_ruv(RFC)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts vectors in RFC (Radar Face Coordinate) to RUV coordinates.
%      Accepts position (3xN); position and velocity (6xN); or position,
%      velocity, and acceleration (9xN) vectors, where N is the number of
%      vectors desired to be transformed.
%
%   Input:
%        RFC        --  state vectors in RFC (3XN, 6XN, or 9XN)
%
%   Output:
%        RUV        -- state vector in RUV coordinates (3XN, 6XN, or 9XN)
%                   
%   Required Functions:
%      Compute_range
%


[m_RFC, n_RFC] = size(RFC);

r   = compute_range( RFC(1:3,:) ); 
u   = RFC(1,:) ./ r;
v   = RFC(2,:) ./ r;

if m_RFC==3;
	RUV = [r; u; v];
   return
end

%We got to here because there are more than just three states
r_dot = sum( RFC(1:3,:).*RFC(4:6,:), 1 ) ./ r;
u_dot = ( RFC(4,:) - u .* r_dot ) ./ r;
v_dot = ( RFC(5,:) - v .* r_dot ) ./ r;

if m_RFC==6;
	RUV   = [r; u; v; r_dot; u_dot; v_dot];
elseif m_RFC==9;
	r_acc = ( sum( RFC(4:6,:) .* RFC(4:6,:), 1 ) + ...
      sum( RFC(1:3,:) .* RFC(7:9,:), 1 ) - r_dot.^2 ) ./ r;
	u_acc = ( RFC(7,:) - 2 * u_dot .* r_dot - u .* r_acc ) ./ r;
	v_acc = ( RFC(8,:) - 2 * v_dot .* r_dot - v .* r_acc ) ./ r;
	RUV   = [r; u; v; r_dot; u_dot; v_dot; r_acc; u_acc; v_acc];
else
	error('RFC_RUV: incorrectly dimensioned input!');
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
