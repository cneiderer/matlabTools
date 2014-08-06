function loadgpib32()
% Loads the dll gpib32. You may need to change the paths in this file.
% You will need to call this before you use any methods for the gpib class.
    loadlibrary('C:\Windows\gpib-32.dll','C:\Program Files\National Instruments\NI-488.2\Languages\DLL Direct Entry\ni488.h', 'alias' , 'gpib32' );
end