classdef gpibio
    
    properties
        buffer % a pointer to the buffer
        ibcnt  % length of buffer from last read
        ibsta  % status
        iberr  % error
        timeout  % timeout
    end % of properties

    methods                  % gpib_obj constructor
           function gpib_obj = gpibio(varargin)
                % Creates a gpib object as a structure containing the following fields:
                %   buffer = ptr to string for gpib reads
                %   cnt    = (ibcnt) number of characters in buffer from last read command
                %   sta    = (ibsta) status byte. see http://cabbat1.cnea.gov.ar/manuales/gpib/r619.html
                %   tmo    = holds the current timeout setting 
                %
                % You will need to load the gpib dll for this code to work. This is
                % accomplished using the following command:
                %
                % loadlibrary('C:\Windows\gpib-32.dll','C:\Program Files\National ...
                % Instruments\NI-488.2\Languages\DLL Direct Entry\ni488.h', 'alias' , 'gpib32' );
                %
                % Where you may need to change the paths of the gpib-32.dll or ni488.h
                % files according to your installation.
                % Be sure to use the alias option, as Matlab doesn't like the dash in
                % the library name. All gpib methods depend on the library name being
                % 'gpi32'
                
                % Determine if the user wants to set the buffersize or
                % default to buffersize = 101
                switch nargin
                    case 0
                        buffersize = 101;
                    case 1
                        buffersize = varargin{1};
                    otherwise
                        error('The gpibio constructor takes 0 or 1 arguments');
                end % switch
                
                % Load the gpib-32.dll if not already loaded.
                if libisloaded('gpib32')==0
                    try 
                        loadlibrary('C:\Windows\system32\gpib-32.dll',@gpibproto,'alias','gpib32');
                    catch
                        loadlibrary('C:\WINDOWS\system32\gpib-32.dll','C:\Program Files\National Instruments\NI-488.2\Languages\DLL Direct Entry\ni488.h', 'alias' , 'gpib32' );
                        disp('error loading gpib-32.dll from prototype')
                        disp('loading from ni488.h ...')
                        
                        if ~libisloaded('gpib32')
                            error('failed to load gpib-32.dll')
                        end % if
                    end % try
                end % if

                disp('gpib-32.dll is loaded')
                % Initialize the pointers for the properties in the gpibio
                % instance.
                gpib_obj.buffer = libpointer('voidPtr',[uint8(blanks(buffersize)) 0]);
                gpib_obj.ibcnt  = libpointer('uint32',0);
                gpib_obj.ibsta  = libpointer('uint16',0);
                gpib_obj.timeout  = libpointer('uint8',10);
                gpib_obj.iberr  = libpointer('uint16',0);
                
           end % function gpibio(varargin)
           
                             % high level methods
                      buffer = read(gpib, ud, cnt) 
                      status = write(gpib, ud, command, terminator)
                     errcode = codeiberr(gpib,err)
                     stacode = codeibsta(gpib,sta)
                             % canonical class methods
                         val = get(gpib, propName)
                               display(gpib)
                             % gpib-32.dll methods
                       ibsta = ibask(gpib,ud, option)
                       ibsta = ibcac(gpib, ud, synchronous)
                       ibsta = ibclr(gpib, ud)
                       ibsta = ibcmd(gpib, ud, command, cnt)
                       ibsta = ibcmda(gpib, ud, command, cnt)
                       ibsta = ibconfig(gpib, ud, option, setting)
                          ud = ibdev(gpib, brd, pad, sad, tmo, send_eoi, eos)
                       ibsta = ibdma(gpib,ud, dma)
                          ud = ibfind(gpib, name)
                       ibsta = ibgts(gpib,ud, shadow_handshake)
                       ibsta = ibist(gpib,ud, ist)
                       ibsta = ibonl(gpib, ud, online)
                       ibsta = ibpad(gpib, ud, pad)
                       ibsta = ibpct(gpib, ud)
                       ibsta = ibppc(gpib, ud, configuration)
                       ibsta = ibrd(gpib, ud, cnt)
                       ibsta = ibrda(gpib, ud, cnt)
             [ibsta, result] = ibrpp(gpib,ud)
                       ibsta = ibrsc(gpib, ud, request_control)
        [ibsta, status_byte] = ibrsp(gpib,ud)
                       ibsta = ibrsv(gpib, ud, status_byte)
                       ibsta = ibsad(gpib,ud, sad)
                       ibsta = ibsic(gpib, ud)
                       ibsta = ibsre(gpib, ud, enable)
                       ibsta = ibstop(gpib, ud)
                       ibsta = ibtmo(gpib, ud, timeout)
                       ibsta = ibtrg(gpib, ud)
                       ibsta = ibwait(gpib,ud, status_mask)
                       ibsta = ibwrt(gpib,ud, data, cnt)
                       ibsta = ibwrta(gpib, ud, data, cnt)   
    end % methods
end % classdef
     