function [radar_attitude, radar_location] = read_radar_setup(fName)
%     [radar_attitude, radar_location] = Read_Radar_Setup(fName)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Gets the radar location and attitude defined by the text file
%      specified by fName.
%
%   Input:
%        fName    --  String that specifies the full path and file name of
%                     the desired file containing the radar's location and
%                     orientation
%
%   Output:
%        radar_attitude  -- The radar face orientation, which is the
%                           azimuth, elevation, and clock angles of the 
%                           radar face.  This is a 3x1 vector, 
%                           [az, el, clock], in the following units: 
%                           [radians, radians, radians]
%        radar_location  -- The radar location, which is the lattitude,
%                           longitude, and altitude of the radar.  This is
%                           a 3x1 vector, [lat, lon, alt], in the following
%                           units: [radians, radians, meters]
%
%   Required Functions:
%        Read_Sap_File
%

DEG2RAD = pi / 180;

var_list = {'latitude', 'longitude', 'altitude', 'azimuth', 'elevation', 'clock'};

tmp_out_vec = zeros(6,1);

%Initialize the output 
radar_attitude = zeros(3,1);
radar_location = zeros(3,1);

%Read the file and return the results in a structure
tmp_struct = read_sap_file(fName);

%Get the field names from the structure
tmp_field_names = fieldnames(tmp_struct);

for ix = 1:length(tmp_field_names)
   
   array_indx = ismember( var_list, tmp_field_names{ix} );
   if any(array_indx)
      %Only fill the temporary output vector if there was something there
      %to use
      tmp_out_vec(array_indx) = tmp_struct.(tmp_field_names{ix});
   end
   
end %looping over the field names

%Conver the proper things from degrees to radians
tmp_out_vec([1 2 4 5 6]) = tmp_out_vec([1 2 4 5 6]) .* DEG2RAD;

%Fill the radar location
radar_location = tmp_out_vec(1:3);

%Fill the radar attitude
radar_attitude = tmp_out_vec(4:6);

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
