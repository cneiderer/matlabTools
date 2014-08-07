function ruvVar = get_measurement_variances( SNR_dB, radarDef, constants )
%
%     ruvVar = GetMeasurementVariances( SNR_dB, radarDef, constants )
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
%
%   DESCRIPTION
%      Calculates the variances of the simulated measurement
%
%   Input:
%        SNR_dB         --  
%        radarDef
%           BSR_R
%           BSR_U
%           BSR_V
%           beamWidthU
%           beamWidthV
%           monopulseK
%           rangeK
%           bandwidth
%
%        constants
%           c_over_2
%
%   Output:
%        ruvVar    --  the R, U, V variances.  (3xN) vector
%
%   Required Functions:
%        GetEclipsingIndices
%

c_2          =  constants.physical_constants.c_over_2;

BSR_R        = radarDef.BSR_R;
BSR_U        = radarDef.BSR_U;
BSR_V        = radarDef.BSR_V;

bwU2         = radarDef.beamWidthU^2;
bwV2         = radarDef.beamWidthV^2;


twice_snr    =  2 * (10.^( SNR_dB / 10 ));
K2           =  radarDef.monopulseK^2;
Kr           =  radarDef.rangeK ;

R3dB         =  ( 1.0 / radarDef.bandwidth ) * c_2; 


ruvVar(1,:)  =  (  R3dB^2 ./( twice_snr * Kr^2 ) ) + (  R3dB^2 / BSR_R^2 );

ruvVar(2,:)  =  ( bwU2 ./ ( twice_snr * K2 ) ) + ( bwU2 / BSR_U^2 );
                                     
ruvVar(3,:)  =  ( bwV2 ./ ( twice_snr * K2 ) ) + ( bwV2 / BSR_V^2 );

return
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     
