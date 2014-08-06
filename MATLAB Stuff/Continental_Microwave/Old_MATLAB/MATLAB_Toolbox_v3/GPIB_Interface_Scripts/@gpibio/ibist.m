function ibsta = ibist(gpib,ud, ist)
%ibist -- set individual status bit (board)
%   ibsta = ibist(ud, ist)
% If ist is nonzero, then the individual status bit of the board specified 
%by the board descriptor ud  is set. If ist is zero then the individual 
%status bit is cleared. The individual status bit is sent by the board in 
%response to parallel polls.
%
%On success, iberr is set to the previous ist value. 

ibsta = calllib('gpib32', 'ibist', ud, ist);
gpib.ibsta.Value = ibsta;
end