NI:GPIB Matlab Wrappers v0.4
--------------------------------
Author: Brent Valle
Contact: brent.valle@case.edu
--------------------------------

CHANGELOG:
----------
v0.4	30 June 2008	Automatically loads the gpib-32.dll during construction of a gpibio object preferrably by prototype gpibproto.m
			Added codeiberr and codeibsta to give helpful status and error code information
			Allow the user to set the size of the gpib buffer during gpibio construction
			Changed display of gpibio objects
			
v0.3	09 May 2008	More elegantly used Matlab class framework
			Added low-level read/write functions
			Changed the class name to 'gpibio' so that the object returned could be 'gpib'

v0.2	30 Apr 2008	Restructured gpib code in terms of a new Matlab class 'gpib'
			Speed improvements in using leaving the buffer as a pointer rather than converting to ASCII automatically
			Fixed initialization code to give the gpib-32.dll an alias rather than rely on Matlab renaming conventions
			
v0.1	28 Feb 2008	First release!!! Most core functions of gpib-32.dll have working wrappers.


USAGE NOTES:
------------
Be sure to unzip these files using the directory structure in the compressed file. The @gpibio folder should be placed somewhere on your Matlab path, but you do not have to add @gpibio to your path.

These wrapper functions were written for Matlab 7.6 (R2008a). A prototype file that tells matlab the input and output datatypes of the dll is included. To construct your own type:

loadlibrary('C:\Windows\system32\gpib-32.dll', 'C:\Program Files\National Instruments\NI-488.2\Languages\DLL Direct Entry\ni488.h', 'mfilename' , 'gpibproto.m','alias','gpib32')

replacing the paths to gpib-32.dll and ni488.h with the appropriate paths on your system.

For me these were:
Windows\system32 and 
Program Files\National Instruments\NI-488.2\Languages\DLL Direct Entry

If loading the dll by this method fails, the constructor proceeds to load the dll using the header file ni488.h

Example:
-----------
All methods have identical stucture to the standard gpib function calls, but they take an additional first argument that is a gpib class object.

% construct a gpib object
gpib = gpibio;

% Get the descriptor for my gpib board. (GPIB board 0)
ud = ibfind(gpib, 'gpib0');  % takes arguments (gpib object, find string)

% Close the board
status = ibonl(gpib, ud, 0); % takes arguments (gpib object, descriptor, 0: offline 1: online)

clear gpib_obj

OR using . notation for methods we could have used

ud = gpib.ibfind('gpib0');
status = gpib.ibonl(ud,0);
statusmsg = gpib.codeibsta(status);

Misc:
-----------

I used a lot of the documentation from the linux gpib library. There could be some cases where this does not apply. 
Not all the wrappers have been tested, and there are a few functions that I have not included. 
Either write the wrapper or email me, and I might just help you out.

COPYRIGHT AND WARRANTY:
-----------------------

Copyright 2008 Brent Valle

    This file is part of National Instruments Matlab Wrappers (@gpibio)
    which is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This software is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.