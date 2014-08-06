function [ ibsta, result ] = ibrpp(gpib,ud)
%ibrpp -- perform a parallel poll (board or device)
%   [ ibsta, result ] = ibrpp(ud)
% ibrpp() causes the interface board to perform a parallel poll, and stores
%the resulting parallel poll byte in the location specified by ppoll_result.
%Bits 0 to 7 of the parallel poll byte correspond to the dio lines 1 to 8, 
%with a 1 indicating the corresponding dio line is asserted. The devices on
%the bus you wish to poll should be configured beforehand with ibppc(). The
%board which performs the parallel poll must be controller-in-charge, and 
%is specified by the descriptor ud. If ud is a device descriptor instead of
%a board descriptor, the device's access board performs the parallel poll.

[ibsta,  outbuf] = calllib('gpib32', 'ibrpp', ud, libpointer('voidPtr',uint8(8)));
result = uint8(outbuf.Value);  
gpib.ibsta.Value = ibsta;
end
