function hfss_AssignSymmetryBoundary(fid,Name,Plane,SymType,Imped_Mult)

fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup") \n');
fprintf(fid, 'oModule.ChangeImpedanceMult %f', Imped_Mult);
fprintf(fid, 'oModule.AssignSymmetry _\n');
fprintf(fid, 'Array("NAME:%s", _\n',Name);

% Get faces on plane to assign symmetry 
FaceArray=getFacesAlongPlane(Plane); %??????????
fprintf(fid, '"Faces:=", %f, _\n', FaceArray);

% Boundary Type
if strcmpi(SymType,'E')
    fprintf(fid, '"IsPerfectE:=", true) \n'); 
elseif strcmpi(SymType,'H')
    fprintf(fid, '"IsPerfectE:=", false) \n'); 
else
    error('Could not identify symmetry type!!!');
end