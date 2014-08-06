function ibsta = ibppc(gpib, ud, configuration)
%ibppc -- parallel poll configure (board or device)
%   ibsta = ibppc(ud, configuration)
% Configures the parallel poll response of the device or board specified by
%ud. The configuration  should either be set to the 'PPD' constant to 
%disable parallel poll responses, or set to the return value of the 
%PPE_byte() inline function to enable and configure the parallel poll 
%response.
%
% After configuring the parallel poll response of devices on a bus, you may
%use ibrpp() to parallel poll the devices. 

ibsta = calllib('gpib032', 'ibcmda', ud, configuration);
gpib.ibsta.Value = ibsta;
end