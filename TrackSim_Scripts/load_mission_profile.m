function missionProfile = load_mission_profile(fName_mision_profile)

%     missionProfile = LoadMissionProfile(fName_mision_profile)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Load the mission profile from a text file
%
%   Input:
%        fName_mision_profile  --  String that specifies the full path and
%                                  file name of the text file containing 
%                                  the radar's mission profile
%
%   Output:
%        missionProfile    --  A structure representing the radar mission
%                              profile.  Requires the following fields:
%           maxTimeIntrack   --  maximum time an object is allowed to stay
%                                in track
%           requestedSNR_dB  --  requested signal to noise ratio
%           dataRate         --  requested data rate
%
%   Required Functions:
%        Read_Sap_File

%Initialize the radar specific parameters
missionProfile     = read_sap_file(fName_mision_profile);

return
