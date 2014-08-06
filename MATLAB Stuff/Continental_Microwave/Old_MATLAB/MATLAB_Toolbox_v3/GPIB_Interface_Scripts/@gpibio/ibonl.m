function ibsta = ibonl( gpib, ud, online )
%ibonl -- close or reinitialize descriptor (board or device)
%   ibsta = ibonl( ud, online )
% If the online is zero, then ibonl() frees the resources associated with 
%the board or device descriptor ud. The descriptor cannot be used again 
%after the ibonl() call.
%
% If the online is nonzero, then all the settings associated with the 
%descriptor (GPIB address, end-of-string mode, timeout, etc.) are reset to 
%their 'default' values. The 'default' values are the settings the 
%descriptor had when it was first obtained with ibdev() or ibfind(). 

ibsta = calllib('gpib32', 'ibonl', ud, online);
gpib.ibsta = ibsta;
end

