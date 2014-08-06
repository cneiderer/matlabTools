% ----------------------------------------------------------------------------
% function hfssFastSweep(fid, Name, SolutionName, fStartGHz, ...
%                                fStopGHz, [nPoints = 100],
% 
% Description :
% -------------
% Create the VB Script necessary to add an fast sweep to an existing
% solution.
% 
% Parameters :
% ------------
% fid          - file identifier of the HFSS script file.
% Name         - name of the interpolating sweep. 
% SolutionName - name of the solution to which this interpolating sweep needs
%                to be added.
% fStartGHz    - starting frequency of sweep in GHz.
% fStopGHz     - stop frequency of sweep in GHz.
% nPoints      - # of output points (defaults to 100).
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssInterpolatingSweep(fid,'Fast600to900MHz','Solve750MHz',0.6, 0.9,);
%


function hfssFastSweep(fid,Name,SolutionName,fStartGHz,fStopGHz,nPoints)
    
if nargin<5
    error('Insufficient # of arguments');
elseif nargin<6 && ~exist(nPoints)
    nPoints=100;
end

% create script.
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("AnalysisSetup")\n');

fprintf(fid, 'oModule.InsertFrequencySweep _\n');
fprintf(fid, '"%s", _\n', SolutionName);
fprintf(fid, 'Array("NAME:%s", _\n', Name);
fprintf(fid, '"IsEnabled:=", true, _\n');
fprintf(fid, '"SetupType:=", "LinearCount", _\n');
fprintf(fid, '"StartValue:=", "%fGHz", _\n', fStartGHz);
fprintf(fid, '"StopValue:=", "%fGHz", _\n', fStopGHz);
fprintf(fid, '"Count:=", %d, _\n', nPoints);
fprintf(fid, '"Type:=", "Fast", _\n');
fprintf(fid, '"SaveFields:=", false, _\n');
fprintf(fid, '"ExtrapToDC:=", false)\n');