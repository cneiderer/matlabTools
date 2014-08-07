function detection = generate_detections(constants, radar, truth)
%     [detection, radar] = GetDetection(loaded, radar, constants)
%
%    UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED     UNCLASSIFIED
%
%   DESCRIPTION
%
%   Input:
%        truth --  structure of truth data
%           RRC
%           RUV
%           time
%
%        radar
%           beam_cmd
%              chirp_sign
%           radarDef
%              referenceSNR
%              referenceRCS
%              referenceRange
%              maximumPulsewidth
%
%           misnProf  --  The structure of the mission profile
%              requestedSNR_dB
%
%        constants
%           c_over_2
%
%   Output:
%        detection    --  A structure representing the radar detection.
%                         Requires the following fields:
%           times       --  The detection times
%           rdc_time    --  The range doppler coupling time
%           ruv_var     --  The R,U,V variance of the detection (3xN)
%           ruv         --  The R,U,V detection (3xN)
%           pulseWidth  --  The width of the pulse used to generate the
%                           detection
%           SNR         --  The signal to noise ration of the detection, dB
%           nDets       --  The number of measurements in this detection
%           chirp_sign  --  The chirp sign used to get the detection
%
%        radar
%           beam_cmd
%              truth_indx  --  index into the truth vector; time index used
%                              to determine which truth time sample is used
%                              to generate a detection
%
%   Required Functions:
%        ComputeSNR
%        GetMeasurementVariances
%        GetMeasurements
%        Target
%
RCS_dB = -5;

BW = radar.beam_cmd.BW;
chirp_sign = radar.beam_cmd.chirp_sign;

radar_defaults = radar.defaults;
mission_profile = radar.mission_profile;
params = radar.params;
pulse = params.pulse;

%wb = waitbar(0, 'Generating Detections');

detection = struct('time',[],'rdc_time',[],'ruv',[],'ruv_var',[],'pw',[],'SNR',[]);

for dd=1:length(truth.time)
%    waitbar(dd/length(truth.time), wb)
    
    RCS = 10^(RCS_dB/10);

    [SNR_dB_out, pw, i_tau] = compute_SNR( RCS, truth.RRC(:,dd), mission_profile.requestedSNR_dB, BW, radar, constants);

    signal_lin = norm( [sqrt(10^(0.1*SNR_dB_out)) 0] + randn(1,2) );
    
    measurement.signal = 20*log10(signal_lin);

    ruv_var = get_measurement_variances( SNR_dB_out, radar_defaults, constants );
if dd==2
    chirp_sign=-1;
else
    chirp_sign=1;
end
    ruv = get_measurements( truth.RUV(:,dd), ruv_var, pulse, i_tau, chirp_sign, radar_defaults );
    
    detection.time(end+1) = truth.time(dd);
    detection.rdc_time(end+1) = pw * radar_defaults.frequency / radar_defaults.bandwidth;
    detection.ruv_var(:,end+1) = ruv_var;
    detection.ruv(:,end+1) = ruv;
    detection.pw(end+1) = pw;
    detection.SNR(end+1) = SNR_dB_out;
end

%close(wb);

return

