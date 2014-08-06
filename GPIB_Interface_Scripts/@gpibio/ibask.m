function ibsta= ibask(gpib,ud, option)
%ibask -- query configuration (board or device)
%   Detailed explanation goes here
%Queries various configuration settings associated with the board or device
%descriptor ud. The option argument specifies the particular setting you 
%wish to query. The result of the query is written to the location 
%specified by result. To change the descriptor's configuration, see ibconfig().

ibsta = calllib('gpib32', 'ibask',ud, option, gpib.buffer);
gpib.ibsta.Value=ibsta;
end