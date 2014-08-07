function RFC = rrc2rfc(T_RRC_RFC, d_RRC_RFC, RRC)
%     RFC = Rrc_rfc(T_RRC_RFC, d_RRC_RFC, RRC)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Converts vectors in RRC to RFC (radar face coordinates).  If
%      T_RRC_RFC is 3X3N, then the RFC is assumed to be rotating relative
%      to RRC.
%
%   Input:
%        RRC        --  state vectors in RRC (3XN, 6XN, or 9XN)
%        T_RRC_RFC  --  RRC to RFC transformation matrix
%        d_RRC_RFC  --  A vector of misalignment errors (3xN)
%
%   Output:
%        RFC        -- state vectors in RFC (3XN, 6XN, or 9XN)
%                   
%   Required Functions:
%        None.
%

[m_RRC, n_RRC]             = size(RRC);
[m_T_RRC_RFC, n_T_RRC_RFC] = size(T_RRC_RFC);

if n_T_RRC_RFC < 3;
   error('RRC_RFC: T_RRC_RFC has less than 3 columns!');
end

if m_T_RRC_RFC < 3
   error('RRC_RFC: T_RRC_RFC has less than 3 rows!');
end

if n_T_RRC_RFC == 3;

   if m_RRC == 3;

      RFC = T_RRC_RFC*RRC(1:3,:) - d_RRC_RFC*ones(1,n_RRC);

   elseif m_RRC == 6;

      RFC = [T_RRC_RFC*RRC(1:3,:) - d_RRC_RFC*ones(1,n_RRC);
             T_RRC_RFC*RRC(4:6,:)];

   elseif m_RRC == 9;

      RFC = [T_RRC_RFC*RRC(1:3,:) - d_RRC_RFC*ones(1,n_RRC);
             T_RRC_RFC*RRC(4:6,:);
             T_RRC_RFC*RRC(7:9,:)];

   end %if there are three rows in the input RRC vector

elseif mod(n_T_RRC_RFC,3) == 0;
   
   ones_vec = ones(3,1);

   if m_RRC == 3;

      RRC_pos = RRC(1:3,:);
      RFC     = ( T_RRC_RFC .* (ones_vec * RRC_pos(:)' - ...
                       d_RRC_RFC * ones(1, 3*n_RRC)) ) * ...
                  kron(eye(n_RRC), ones_vec );

   elseif m_RRC == 6;

      RRC_pos = RRC(1:3,:);
      RRC_vel = RRC(4:6,:);
      RFC     = [ T_RRC_RFC .* ( ones_vec * RRC_pos(:)' - ...
                       d_RRC_RFC * ones(1, 3*n_RRC) );
                  T_RRC_RFC .* (ones_vec * (RRC_vel(:))') ] * ...
                  kron(eye(n_RRC), ones_vec);

   elseif m_RRC == 9;

      RRC_pos = RRC(1:3,:);
      RRC_vel = RRC(4:6,:);
      RRC_acc = RRC(7:9,:);
      RFC     = [ T_RRC_RFC .* ( ones_vec*RRC_pos(:)' - ...
                       d_RRC_RFC * ones(1,3*n_RRC) );
                  T_RRC_RFC .* ( ones_vec*(RRC_vel(:))' );
                  T_RRC_RFC .* ( ones_vec*(RRC_acc(:))' ) ] *...
                  kron(eye(n_RRC), ones_vec);

   else
      error('RRC_RFC: incorrectly dimensioned input!');
   end %if there are three rows in the input RRC vector
else
   error('RRC_RFC: T_RRC_RFC has a number of columns not a multiple of 3!');
end %if there are three clumns in T_RRC_RFC

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
