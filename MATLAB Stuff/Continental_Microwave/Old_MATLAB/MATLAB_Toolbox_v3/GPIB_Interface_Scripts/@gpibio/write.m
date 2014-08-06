function [ status ] = write(gpib, ud, command, terminator )
%GPIB_WRITE: Write a string to a GPIB device.
    %  retval  = gpib_write( ud, command, terminator )
    % terminator codes
    % 0 -> no terminator
    % 1 -> \n LF
    % 2 -> \r CR
    % 3 -> \f FF
    % 4 -> \r\n Carriage return, Line Feed
    
    %check terminator input and set terminator to correct setting   
    if terminator==0
            term=''; % no terminator
        elseif terminator==1
            term='\n'; % Linefeed
        elseif terminator==2
            term='\r'; % carriage return
        elseif terminator==3
            term='\f'; % probably not ever used
        elseif terminator==4
            term='\r\n'; % CRLF
    else
        disp 'terminator must be 0,1,2,3 or 4'
        return
    end
    
    %calculate string length
    count = length(command) + length(term)/2;
    
    ibtmo(gpib, ud, 10);
    status=ibwrt(gpib, ud, [command sprintf(term)],count);