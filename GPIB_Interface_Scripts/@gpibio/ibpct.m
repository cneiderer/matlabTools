function ibsta = ibpct(gpib, ud )
%ibpct -- pass control (board)
%   ibsta = ibpct( ud )
%ibpct() passes control to the device specified by the device descriptor
%ud. The device becomes the new controller-in-charge.

ibsta = calllib('gpib32', 'ibpct', ud);
gpib.ibsta.Value = ibsta;
end
