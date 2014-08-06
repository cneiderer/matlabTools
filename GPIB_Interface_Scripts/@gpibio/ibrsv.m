function ibsta = ibrsv(gpib, ud, status_byte )
%ibrsv -- request service (board)
%   ibsta = ibrsv( ud, status_byte)
%The serial poll response byte of the board specified by the board
%descriptor ud is set to status_byte. If the request service bit 
%(0x40 hexadecimal) in status_byte  is set, then the board will also 
%request service by asserting the RQS line.

ibsta = calllib('gpib32', 'ibrsv', ud, status_byte);
gpib.ibsta.Value = ibsta;
end