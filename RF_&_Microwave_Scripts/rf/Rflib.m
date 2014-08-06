function rflib
% RFLIB  Open the RF Circuits Toolbox SIMULINK Block Library.
%       RFLIB opens the top level of the RF Circuits Toolbox
%       SIMULINK Block Library. When SIMULINK is not installed in
%       the MATLABPATH, this function displays an error mesasge
%       at the MATLAB prompt.
%

if exist('simulink')
    if exist('rf')
        open_system('rf');
    else
        error('You have not loaded the RF Circuits SIMULINK Block Library yet.'); 
    end;
else
    error('You need SIMULINK to open the RF Circuits SIMULINK Block Library.'); 
end;
