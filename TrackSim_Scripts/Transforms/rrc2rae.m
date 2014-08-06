function RAE = rrc2rae(RRC)
%
%     RAE = Rrc_rae(RRC)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts vectors in RRC to RAE coordinates
%
%   Input:
%        RRC        -- state vector in RRC coordinates (3XN, 6XN, or 9XN)
%
%   Output:
%        RAE        -- state vector in RAE coordinates (3XN, 6XN, or 9XN)
%                      in R (m), AZ (rad), EL (rad) coordinates and
%                      (m/sec), (rad/sec), (rad/sec)
%                   
%   Required Functions:
%      Compute_range
%      Column_Norm
%

if length(size(RRC)) == 3
   % convert (3,:,:) to (:,:)
   single_i = find(size(RRC) == 1);
   if single_i == 1
      tmp(:,:) = RRC(1,:,:);
   elseif single_i == 2
      tmp(:,:) = RRC(:,1,:);
   elseif single_i == 3
      tmp(:,:) = RRC(:,:,1);
   end
   RRC = tmp;
end

range = compute_range( RRC(1:3,:) );
el    = asin(RRC(3,:)./range);
az    = atan2(RRC(1,:),RRC(2,:));

if size(RRC,1) == 3
   RAE = [range; az; el];
elseif size(RRC,1) == 6
   rho      = column_norm(RRC(1:2,:));
   rho_sqrd = rho.^2;
   rho_dot  = sum(RRC(1:2,:) .* RRC(4:5,:)) ./ rho;
   r_dot    = sum(RRC(4:6,:) .* RRC(1:3,:)) ./ range;
   az_dot   = sum([RRC(2,:); -1*RRC(1,:)] .* RRC(4:5,:)) ./ rho_sqrd;
   el_dot   = ((rho.*RRC(6,:) - RRC(3,:) .* rho_dot) ./ (range.^2));
   RAE      = [range; az; el; r_dot; az_dot; el_dot];
else
   error('Rrc_rae: incorrectly dimensioned input!!!');
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
