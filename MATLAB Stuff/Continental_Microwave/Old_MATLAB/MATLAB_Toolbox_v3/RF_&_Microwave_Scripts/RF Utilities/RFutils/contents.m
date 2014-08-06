% RF Utilities V1.0
%
% Directories : RFutils & RFutils_S
%
% Display routines
%   smith       - Smith chart.
%   sadmit      - Admittance chart.
%   scomb       - Smith / Admittance chart.
%   smdrawc     - Draw impedance on smith chart.
%   smarker1    - Put markers on Smith charts.
%   samarker1   - Put markers on Admittance charts.
%   smcirc      - Draw VSWR circle on smith chart.
%   
%   vswrc       - Plot VSWR vs frequency
%   vsdrawc     - Add VSWR trace to an existing plot
%   vmarker1    - Put markers on VSWR traces
%
%   rlossc      - Plot Return Loss vs frequency
%   rldrawc     - Add Return Loss trace to an existing plot
%   rmarker1    - Put markers on Return Loss traces
%
%   mlossc      - Plot Mismatch Loss vs frequency
%   mldrawc     - Add Mismatch Loss trace to an existing plot
%   mmarker1    - Put markers on Mismatch Loss traces
%
%   ilossc      - Plot Insertion Loss vs frequency
%   ildrawc     - Add Insertion Loss trace to an existing plot
%   imarker1    - Put markers on Insertion Loss traces
%
%   phdelayc    - Plot Phase Delay vs frequency
%   phdrawc     - Add Phase Delay trace to an existing plot
%   phmarker1   - Put markers on Phase Delay traces
%
%   gdelayc     - Plot Group Delay vs frequency
%   gdrawc      - Add Group Delay trace to an existing plot
%   gmarker1    - Put markers on Group Delay traces
%
%
%
% Lumped element components
%   trl         - Transmission line model for lossy line
%   rseries     - Series resistance
%   rshunt      - Shunt resistance
%   lseries     - Series inductance
%   lshunt      - Shunt inductance
%   cseries     - Series capacitance
%   cshunt      - Shunt capacitance
%
% Utilities
%   tdr         - Time Domain Reflectometry (impedance vs distance)
%   citi1       - Load 1-port citi file as an input impedance
%   citi1s      - Load 1-port citi file as S-params
%   citi2s      - Load 2-port citi file as S-params
%   s2z         - Convert single S-param vector to impedance Z
%   z2s         - Convert single impedance vector Z to S-param
%   s2mm        - Convert standard S-param to mixed-mode S-params (4-port)
%   loads2p     - Load 2-port S2P files (as output by RFSim99)
%   loadsonnet4 - Load 4-port S-parameter data (as output by Sonnet Lite)
%   gslbl       - Add leader and text label at point on chart selected by mouse
%   gsmpt       - Show impedance at points on Smith Chart selected by mouse
%   textsc      - Places text at screen coords on current figure
%
% Subroutines 
%   smsub1&2 }
%   sasub1&2 }  - Impedance chart subroutines 
%   scsub1&2 }
%
% Examples
%   example1    - Transmission line matching example for smith.m
%   example2    - Lumped element matching example for scomb.m
%   example3    - Transmission line matching example for vswr.m
%   example4    - Cascaded Tx-Line filter example for rlossc.m and mlossc.m
%   example5    - Use of the CITI file loader 
%                 (Note: path to test files my need to be changed in example5.m)
%
%   example6    - Time Domain Reflectometry, measuring line impdances
%   example7    - Time Domain Reflectometry, lumped element discontinuities
%   example8    - Plotting transmission parameters, imported from a CITI file
%                 using citi2s.m (Note: path to test file may need to be changed)
%
%   example9    - Plotting impedances and transmission parameters imported 
%                 from an S2P file exported from RFsim99
%                 (Note: path to test file may need to be changed in example9.m)
%
%   example10   - Plotting differential impedances and TDR on differential lines.
%                 The source data is modelled and imported from Sonnet Lite
%                 (Note: path to test file may need to be changed in example10.m)
%
%   example11   - Using the standard to mixed mode S-param function s2mm.m
%                 Plotting common mode impedances and TDR on differential lines.
%                 The source data is modelled and imported from Sonnet Lite
%                 (Note: path to test file may need to be changed in example11.m)

% N.Tucker www.activefrance.com 2008