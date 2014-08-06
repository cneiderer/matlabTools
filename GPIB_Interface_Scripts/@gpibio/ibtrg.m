function ibsta = ibtrg(gpib, ud)
%ibtrg -- trigger device (device)
%   ibsta = ibtrg( ud)
%ibtrg() sends a GET (group execute trigger) command byte to the device
%specified by the device descriptor ud.

ibsta = calllib('gpib32', 'ibtrg', ud);
gpib.ibsta.Value = ibsta;
end
