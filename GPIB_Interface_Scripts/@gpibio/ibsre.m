function ibsta = ibsre(gpib, ud, enable)
%ibsre -- set remote enable (board, enable)
%   Detailed explanation goes here
%If enable is nonzero, then the board specified by the board descriptor ud
%asserts the REN line. If enable is zero, the REN line is unasserted. The 
%board must be the system controller.

ibsta = calllib('gpib32', 'ibsre', ud, enable);
gpib.ibsta.Value = ibsta;
end