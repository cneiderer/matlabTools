function RFC = ruv2rfc(RUV)
%     RFC = Ruv_rfc(RUV)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts vectors in RUV coordinates to RFC (radar face coordinates)
%
%   Input:
%        RUV        --  state vectors in RUV (3XN, 6XN, or 9XN)
%
%   Output:
%        RFC        -- state vector in RFC coordinates (3XN, 6XN, or 9XN)
%                   
%   Required Functions:
%      None
%

[m_RUV, n_RUV] = size(RUV);

if m_RUV == 3;
   
   x_RFC = RUV(1,:) .* RUV(2,:); 
   y_RFC = RUV(1,:) .* RUV(3,:); 
   z_RFC = RUV(1,:) .* sqrt(1-RUV(2,:).^2 - RUV(3,:).^2);
   
	RFC   = [x_RFC; y_RFC; z_RFC];
   
elseif m_RUV == 6;
   
   w_RUV     = sqrt(1-RUV(2,:).^2 - RUV(3,:).^2);
   w_RUV_dot = (-RUV(2,:) .* RUV(5,:) - RUV(3,:) .* RUV(6,:)) ./ w_RUV;
   
	x_RFC = RUV(1,:) .* RUV(2,:);
   y_RFC = RUV(1,:) .* RUV(3,:);
   z_RFC = RUV(1,:) .* w_RUV;
   
   x_RFC_dot = RUV(4,:) .* RUV(2,:) + RUV(1,:) .* RUV(5,:);
   y_RFC_dot = RUV(4,:) .* RUV(3,:) + RUV(1,:) .* RUV(6,:);
   z_RFC_dot = RUV(4,:) .* w_RUV+RUV(1,:) .* w_RUV_dot;
   
	RFC = [x_RFC; y_RFC; z_RFC; x_RFC_dot; y_RFC_dot; z_RFC_dot];
   
elseif m_RUV == 9;
   
	w_RUV     = sqrt(1 - RUV(2,:).^2 - RUV(3,:).^2);
   
	w_RUV_dot = (-RUV(2,:) .* RUV(5,:) - RUV(3,:) .* RUV(6,:)) ./ w_RUV;
   
	w_RUV_acc = (-RUV(5,:).^2 - RUV(6,:).^2 - w_RUV_dot.^2 - ...
                 RUV(2,:) .* RUV(8,:) - RUV(3,:) .* RUV(9,:)) ./ w_RUV;
   %
   x_RFC = RUV(1,:) .* RUV(2,:); 
   y_RFC = RUV(1,:) .* RUV(3,:); 
   z_RFC = RUV(1,:) .* w_RUV;
   
   x_RFC_dot = RUV(4,:) .* RUV(2,:) + RUV(1,:) .* RUV(5,:);
   y_RFC_dot = RUV(4,:) .* RUV(3,:) + RUV(1,:) .* RUV(6,:);
   z_RFC_dot = RUV(4,:) .* w_RUV + RUV(1,:) .* w_RUV_dot;
   
   x_RFC_acc = RUV(7,:) .* RUV(2,:) + 2*RUV(4,:) .* RUV(5,:) + ...
               RUV(1,:) .* RUV(8,:);
   y_RFC_acc = RUV(7,:) .* RUV(3,:) + 2*RUV(4,:) .* RUV(6,:) + ...
               RUV(1,:) .* RUV(9,:);
   z_RFC_acc = RUV(7,:) .* w_RUV + 2*RUV(4,:) .* w_RUV_dot + ...
               RUV(1,:) .* w_RUV_acc;
   
   RFC = [x_RFC; y_RFC; z_RFC; 
          x_RFC_dot; y_RFC_dot; z_RFC_dot; 
          x_RFC_acc; y_RFC_acc; z_RFC_acc];
       
else
	error('RUV_RFC: incorrectly dimensioned input!!!');
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
