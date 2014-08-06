function w = Cross3( u, v, nf )
%     w = Cross3( u, v, nf )
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Vector Crossproduct in Three-Dimensional Space.
%
%   Input:
%        u   --  3x1 vector 1
%        v   --  3x1 vector 2
%        nf  --  Normalization flag for u x v 
%            0 = crossproduct w/o normalization
%            1 = normalized crossproduct
%
%   Output:
%        w -- 3x1 crossproduct vector u x v
%                   
%   Required Functions:
%        None
%

%#mex

[nxu, nyu] = size(u);
[nxv, nyv] = size(v);

if (nxu < 3) || (nxv < 3)
   error('Cross3:  Input vectors have fewer than 3 rows');
end

uxv = [ 
    u(2,1)*v(3,1)-v(2,1)*u(3,1);
    u(3,1)*v(1,1)-v(3,1)*u(1,1);
    u(1,1)*v(2,1)-v(1,1)*u(2,1);
];

if nf == 0
    
    w = uxv;
    
end

if nf == 1

    w = uxv;  uxvm = norm( uxv );
    
    if uxvm > 0
        
        w = uxv/norm( uxv );
        
    end
    
end

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
