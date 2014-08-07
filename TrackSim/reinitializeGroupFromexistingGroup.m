function [groupOut] = reinitializeGroupFromexistingGroup (groupIn,numStatesOutputGroup,map_saps);



groupOut.time = groupIn.time;

if numStatesOutputGroup == 6

%     groupOut.svRRC = GroupIn.svRRC(1:numStatesOutputGroup);
%     groupOut.svRUV = GroupIn.svRUV(1:numStatesOutputGroup);
% 
%     groupOut.covRRC = GroupIn.covRRC(1:numStatesOutputGroup);
%     groupOut.covRRC = GroupIn.covRRC(1:numStatesOutputGroup);
groupOut=groupIn;
groupOut.track_type=2;
groupOut.acceleration=[  0;
                             0;
                             0;
                             0;];
                         
elseif numStatesOutputGroup == 10
    groupOut=groupIn;
    groupOut.track_type=3;
    groupOut.acceleration=[  map_saps.map_tp_sap_6015;
                             map_saps.map_tp_sap_6016;
                             map_saps.map_tp_sap_6017;
                             map_saps.map_tp_sap_6018;];
                         
 groupOut.cov_rrc(7,7)       = map_saps.map_tp_sap_6019;
    groupOut.cov_rrc(8,8)    = map_saps.map_tp_sap_6020;
    groupOut.cov_rrc(9,9)    = map_saps.map_tp_sap_6021;
    groupOut.cov_rrc(10,10)	= map_saps.map_tp_sap_6022;


    groupOut.cov_ruv(7,7)    = map_saps.map_tp_sap_6019;
    groupOut.cov_ruv(8,8)    = map_saps.map_tp_sap_6020;
    groupOut.cov_ruv(9,9)    = map_saps.map_tp_sap_6021;
    groupOut.cov_ruv(10,10)  = map_saps.map_tp_sap_6022;
    
%                             groupOut.svRRC = [groupIn.svRRC(1:6);
%                             map_saps.map_tp_sap_6015;
%                             map_saps.map_tp_sap_6016;
%                             map_saps.map_tp_sap_6017;
%                             map_saps.map_tp_sap_6018;];
% 
%     groupOut.svRUV =        [groupIn.svRUV(1:6);
%                             map_saps.map_tp_sap_6015;
%                             map_saps.map_tp_sap_6016;
%                         	map_saps.map_tp_sap_6017;
%                             map_saps.map_tp_sap_6018;];
% 
%     groupOut.covRRC         = zeros(1);
%     groupOut.covRRC(1:6,1:6)= groupIn.covRRC(1:6,1:6);
%     groupOut.covRRC(7,7)    = map_saps.map_tp_sap_6019;
%     groupOut.covRRC(8,8)    = map_saps.map_tp_sap_6020;
%     groupOut.covRRC(9,9)    = map_saps.map_tp_sap_6021;
%     groupOut.covRRC(10,10)	= map_saps.map_tp_sap_6022;
% 
%     groupOut.covRUV         = zeros(1);
%     groupOut.covRUV(1:6,1:6)= groupIn.covRUV(1:6,1:6);
%     groupOut.covRUV(7,7)    = map_saps.map_tp_sap_6019;
%     groupOut.covRUV(8,8)    = map_saps.map_tp_sap_6020;
%     groupOut.covRUV(9,9)    = map_saps.map_tp_sap_6021;
%     groupOut.covRUV(10,10)  = map_saps.map_tp_sap_6022;
    
  
end