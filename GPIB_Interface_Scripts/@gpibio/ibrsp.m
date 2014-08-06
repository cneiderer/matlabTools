function [ ibsta, status_byte ] = ibrsp(gpib,ud)
%ibrsp -- conduct serial poll (device)
%   ibrsp() serial polls the device specified by ud. The status byte is
%   stored in the location specified by result.

bufptr = libpointer('voidPtr',uint8(16)); % create buffer pointer
ibsta = calllib('gpib32', 'ibrsp', ud, bufptr);
status_byte = bufptr.value;   % convert bufptr to string
gpib.ibsta.Value = ibsta;
end
