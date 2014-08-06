function [ buffer ] = read( gpib, ud, cnt )
%GPIB_READ Low Level reading of GPIB buffer
    %  gpib_buffer = gpib_read(gpib, ud, cnt )
    % Takes descriptor ud from ibdev and count is the number of bytes of
    % buffer to read.
    % Returns buffer as a string.

    if ~(gpib.timeout.Value==11)   % this is an optional section that lengthens 
        ibtmo(gpib, ud,11);      % the timeout for reads from the gpib
    end

    ibrd(gpib, ud ,cnt);
    buffer = char(gpib.buffer.Value(1:gpib.ibcnt.Value));  % convert bufptr to string
    gpib.buffer.Value(1:gpib.ibcnt.Value) = ' '; % clear out buffer
end