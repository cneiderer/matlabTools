function hfss_InsertOptimization(fid,SetupName,SweepName,OptimSetupName,...
    VarName,OptimType,MaxIter,ReportType,Range,Calc,Condition,Cost,Noise)

fprintf(fid, 'SetupoModule.InsertSetup "OptiOptimization", _\n');
fprintf(fid, 'Array("NAME:OptimizationSetup1", _\n');
fprintf(fid, 'Array("NAME:ProdOptiSetupData", _\n');
fprintf(fid, '"SaveFields:=", false, _\n');
fprintf(fid, '"CopyMesh:=", false), _\n');
	
fprintf(fid, 'Array("NAME:StartingPoint"), _\n');
fprintf(fid, '"Optimizer:=", "%s", _\n', OptimType);
fprintf(fid, 'Array("NAME:AnalysisStopOptions", _\n');
fprintf(fid, '"StopForNumIteration:=", true, _\n');
fprintf(fid, '"StopForElapsTime:=", false, _\n');
fprintf(fid, '"StopForSlowImprovement:=", false, _\n');
fprintf(fid, '"StopForGrdTolerance:=", false, _\n');
fprintf(fid, '"MaxNumIteration:=", 100, _\n', MaxIter);
fprintf(fid, '"MaxSolTimeInSec:=", 3600, _\n');
fprintf(fid, '"RelGradientTolerance:=", 0), _\n');
		
fprintf(fid, '"CostFuncNormType:=", "L2", _\n'); 
fprintf(fid, '"PriorPSetup:=", "", _\n'); 
fprintf(fid, '"PreSolvePSetup:=", true, _\n'); 
fprintf(fid, 'Array("NAME:Variables"), _\n');
fprintf(fid, 'Array("NAME:LCS"), _\n');
fprintf(fid, 'Array("NAME:Goals", _\n');
fprintf(fid, 'Array("NAME:Goal", _\n');
fprintf(fid, '"ReportType:=", _\n', ReportType);
fprintf(fid, '"Solution:=", "%s : %s", _\n', SetupName, SweepName);
fprintf(fid, 'Array("NAME:SimValueContext"), _\n');
fprintf(fid, '"Calculation:=", "%s" _\n', Calc); % i.e. dB(S(P1,P1))
fprintf(fid, '"dB(S(WavePort1,WavePort1))", _\n');

% Frequency Points
fprintf(fid, 'Array("NAME:Ranges", _\n');
fprintf(fid, '"Range:=", _\n');
fprintf(fid, 'Array("Var:=", _\n');
fprintf(fid, '"Freq", _\n');
fprintf(fid, '"Type:=", "d", _\n'); 

nfreqPts=length(Range); %
for ii=1:nfreqPts
    fprintf(fid, '"DiscreteValues:=", "%f%s", _\n', freqPts);
end	

% Cost Function Definition
fprintf(fid, '"Condition:=", "s", _\n', Condition);
fprintf(fid, 'Array("NAME:GoalValue", _\n'); 
fprintf(fid, '"GoalValueType:=", _\n'); 
fprintf(fid, '"Independent", _\n'); 
fprintf(fid, '"Format:=", _\n'); 
fprintf(fid, '"Real/Imag", _\n'); 
fprintf(fid, '"bG:=", _\n'); 
fprintf(fid, 'Array("v:=", "[-10]")), _\n'); 
fprintf(fid, '"Weight:=", "[1]"), _\n'); 
fprintf(fid, '"Acceptable_Cost:=", "%f" _\n',Cost);
fprintf(fid, '"Noise:=", "%f" _\n',Noise);
fprintf(fid, '"UpdateDesign:=", false, _\n'); 
fprintf(fid, '"UpdateIteration:=", 5, _\n'); 
fprintf(fid, '"KeepReportAxis:=", true, _\n'); 
fprintf(fid, '"UpdateDesignWhenDone:=", false) _\n'); 