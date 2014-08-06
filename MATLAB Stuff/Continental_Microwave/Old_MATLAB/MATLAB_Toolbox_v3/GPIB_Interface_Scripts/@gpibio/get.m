function val = get(gpib, propName)
% GET Get asset properties from the specified object
% and return the value
switch propName
case 'buffer'
   val = gpib.buffer.Value;
case 'ibcnt'
   val = gpib.ibcnt.Value;
case 'ibsta'
   val = gpib.ibsta.Value;
case 'timeout'
   val = gpib.timeout.Value;
otherwise
   error([propName,' Is not a valid asset property'])
end