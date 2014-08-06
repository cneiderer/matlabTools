function [ ibsta ] = ibclr(gpib, ud )
%ibclr -- clear device (device)
%   [ ibsta ] = ibclr( ud )
% ibclr() sends the clear command to the device specified by ud.

ibsta = calllib('gpib32', 'ibclr', ud);
gpib.ibsta.Value = ibsta;
end
