function hfss_InsertParametricSetup(fid,SetupName,ParamSetupName,VarName,...
    SweepType,SweepStart,SweepStop,SweepStep,Units)

fprintf(fid, 'Set oModule = oDesign.GetModule("Optimetrics") \n');
fprintf(fid, 'oModule.InsertSetup "OptiParametric", _\n');

%% Parameters
fprintf(fid, 'Array("NAME:ParametricSetup1", _\n');
fprintf(fid, 'Array("NAME:ProdOptiSetupData", _\n');
fprintf(fid, '"SaveFields:=", false, _\n');
fprintf(fid, '"CopyMesh:=", false), _\n');
fprintf(fid, 'Array("NAME:StartingPoint"), _\n');
fprintf(fid, '"Sim. Setups:=", _\n');
fprintf(fid, 'Array("%s"), _\n', SetupName);

% Parametric Sweep Definitions
fprintf(fid, 'Array("NAME:Sweeps", _\n');
fprintf(fid, 'Array("NAME:SweepDefinition", _\n');
fprintf(fid, '"Variable:=", "%s", _\n', VarName);
fprintf(fid, '"Data:=", "%s LIN %f%s %f%s %f%s", _\n', ...
    upper(SweepType), ...  %Type (i.e. Linear=LIN, LinearCount=LINC)
    SweepStart, Units, ... %Start
    SweepStop, Units, ...  %Stop
    SweepStep, Units);     %Step
fprintf(fid, '"OffsetF1:=", false, _\n');
fprintf(fid, '"Synchronize:=", 0)), _\n');
fprintf(fid, 'Array("NAME:Sweep Operations"), _\n');
fprintf(fid, 'Array("NAME:Goals")) \n');