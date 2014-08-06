%   DRAWING FILTER REALIZATIONS TOOLBOX
%   Version 2.1   23-Sep-2000
%                 
%   Authors: Miroslav D. Lutovac, Dejan V. Tosic, 1999/02/21
%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/
%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/
%   Copyright (c) 1999-2000 by Lutovac & Tosic
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
%   
%   References:
%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
%        Filter Design for Signal Processing
%           Using MATLAB and Mathematica
%        Prentice Hall - ISBN 0-201-36130-2 
%         http://www.prenhall.com/lutovac
%   
%  MAIN SCRIPT, BASIC OPERATIONS, DEMOS and OTHER
%   drawfilt.m   -  Run DrawFilt - drawing filter realizations (main script)
%   drawdfil.m   -  Drawing digital filter realizations (main script)
%   afalbum.m    -  Album of analog filter realizations (main script)
%   dfalbum.m    -  Album of digital filter realizations (main script)
%   startme1.m   -  Run drawfilt.m
%   contents.m   -  This file
%   demodraw.m   -  Demo
%   
%   auxfilt.m    -  Auxiliary drawing
%   readmedf.txt -  last minute changes and DrawFilt introduction
%   
% WHAT'S NEW 
%   readmedf   - New features and enhancements in this version.
%   
% BUTTONS
%   bdelete.m    -  Button: Delete object
%   bdrw4tbl.m   -  Button: Draw 4 terminal block
%   bdrwadd.m    -  Button: Draw adder
%   bdrwarrw.m   -  Button: Draw arrow
%   bdrwblo.m    -  Button: Draw single-input single-output block
%   bdrwcap.m    -  Button: Draw capacitor
%   bdrwcc.m     -  Button: Draw current conveyor
%   bdrwccs.m    -  Button: Draw controlled current source
%   bdrwcs.m     -  Button: Draw current source
%   bdrwcvs.m    -  Button: Draw controlled voltage source
%   bdrwdel.m    -  Button: Draw delay
%   bdrwdown.m   -  Button: Draw down sampler
%   bdrwedit.m   -  Button: Edit object 
%   bdrwgrnd.m   -  Button: Draw ground
%   bdrwimp.m    -  Button: Draw impedance
%   bdrwin.m     -  Button: Draw input
%   bdrwinfo.m   -  Button: Show short help
%   bdrwlhv.m    -  Button: Draw line horizontal + vertical
%   bdrwline.m   -  Button: Draw line between 2 points
%   bdrwlnd.m    -  Button: Draw inductor
%   bdrwload.m   -  Button: Load schematic from auxfilt.m
%   bdrwlvh.m    -  Button: Draw line vertical + horizontal
%   bdrwmath.m   -  Button: Export to Mathematica 
%   bdrwmult.m   -  Button: Draw multiplier
%   bdrwnode.m   -  Button: Draw node
%   bdrwopam.m   -  Button: Draw operational amplifier (OpAmp)
%   bdrwopen.m   -  Button: Open schematic
%   bdrwota.m    -  Button: Draw OTA
%   bdrwout.m    -  Button: Draw output
%   bdrwredr.m   -  Button: Redraw schematic 
%   bdrwres.m    -  Button: Draw resistor
%   bdrwsaas.m   -  Button: Save schematic
%   bdrwsave.m   -  Button: Save schematic in auxfilt.m
%   bdrwtext.m   -  Button: Draw text
%   bdrwupsa.m   -  Button: Draw up sampler
%   bdrwvs.m     -  Button: Draw voltage source
%   bundo.m      -  Button: Undo
%   
% INTERNALLY USED UTILITY ROUTINES
%   butdraw.m    -  Generate buttons: Draw Digital & Analog Filter Realizations
%   butdrawd.m   -  Generate buttons: Draw Digital Filter Realizations
%   dfalbut.m    -  Generate buttons: Album of Digital Filter Realizations
%   afalbut.m    -  Generate buttons: Album of Analog Filter Realizations
%   dinsstra.m   -  Internal utility
%   editstr.m    -  Edit schematic parameters utility
%   editstra.m   -  Edit schematic parameters utility
%   editstrd.m   -  Edit schematic parameters utility
%   
% DRAW
%   draw4tbl.m   -  Draw 4 terminal block
%   drawadd.m    -  Draw adder
%   drawamp.m    -  Draw amplifier
%   drawarrw.m   -  Draw arrow
%   drawblo.m    -  Draw single-input single-output block
%   drawcap.m    -  Draw capacitor
%   drawcc.m     -  Draw current conveyor
%   drawccs.m    -  Draw controlled current source
%   drawcs.m     -  Draw current source
%   drawcvs.m    -  Draw controlled voltage source
%   drawdel.m    -  Draw delay
%   drawdown.m   -  Draw down sampler
%   drawflib.m   -  Mathematica DrawFilt library
%   drawgrid.m   -  Draw grid
%   drawgrnd.m   -  Draw ground
%   drawimp.m    -  Draw impedance
%   drawin.m     -  Draw input
%   drawlhv.m    -  Draw line horizontal + vertical
%   drawline.m   -  Draw line between 2 points
%   drawlnd.m    -  Draw inductor
%   drawlvh.m    -  Draw line vertical + horizontal
%   drawmath.m   -  Draw schematic in Mathematica
%   drawmult.m   -  Draw multiplier
%   drawnode.m   -  Draw node
%   drawopam.m   -  Draw operational amplifier (OpAmp)
%   drawota.m    -  Draw OTA
%   drawout.m    -  Draw output
%   drawres.m    -  Draw resistor
%   drawtext.m   -  Draw text
%   drawupsa.m   -  Draw up sampler
%   drawvs.m     -  Draw voltage source
%   
% MATHEMATICA
%   drawmath.ma  -  Template notebook for Mathematica 2.x DrawFilt
%   drawmath.nb  -  Template notebook for Mathematica 3.x DrawFilt

% EXAMPLE schematics
%   example1.m   -  Example 1: Draw third-order digital filter
%   example2.m   -  Example 2: Draw cascade realization -- direct-form II biquad
%   example3.m   -  Example 3: Draw Kerwin-Huelsman-Newcomb analog filter realization
%   example4.m   -  Example 4: Draw all objects
%   example5.m   -  Example 5: Draw transpose-direct-form II biquad
%   example6.m   -  Example 6: Draw Ansari-Liu digital filter realization (biquad)
%   
% EXAMPLE ALBUM
%   drawall.m    -  Draw all objects
%   
% EXAMPLE ALBUM\CC
%   drawccsk.m   -  Draw CC Sallen-Key biquad
%   
% EXAMPLE ALBUM\CIRCUITS
%   cdivider.m   -  Draw current divider
%   vdivider.m   -  Draw voltage divider
%   fbvamp.m     -  Draw feedback voltage amplifier
%   
% EXAMPLE ALBUM\DIGITAL
%   draw3rd.m    -  Draw third-order digital filter
%   drawap1a.m   -  Draw Ansari-Liu digital filter first-order realization type A
%   drawap1b.m   -  Draw Ansari-Liu digital filter first-order realization type B
%   drawap1c.m   -  Draw Ansari-Liu digital filter first-order realization type C
%   drawap2a.m   -  Draw Ansari-Liu digital filter realization -- biquad type A
%   drawap2b.m   -  Draw Ansari-Liu digital filter realization -- biquad type B
%   drawap2c.m   -  Draw Ansari-Liu digital filter realization -- biquad type C
%   drawcdf2.m   -  Draw cascade realization -- direct-form II biquad
%   drawdf1.m    -  Draw first-order direct-form II
%   drawdf2b.m   -  Draw direct-form II biquad
%   drawtdf1.m   -  Draw first-order transpose-direct-form II
%   drawtdf2.m   -  Draw transpose-direct-form II biquad
%   dfircf.m     -  Draw cascade FIR realization
%   dfirdfa.m    -  Draw direct form FIR realization
%   dfirlp1.m    -  Draw linear-phase FIR realization type 1
%   dfirlp2.m    -  Draw linear-phase FIR realization type 2
%   dfirtdfa.m   -  Draw transpose direct form FIR realization
%   
% EXAMPLE ALBUM\OPAMP
%   drawaphq.m   -  Draw allpass high-Q-factor op amp RC biquad
%   drawaplq.m   -  Draw allpass low-Q-factor op amp RC biquad
%   drawapmq.m   -  Draw allpass medium-Q-factor op amp RC biquad
%   drawbphq.m   -  Draw bandpass high-Q-factor op amp RC biquad
%   drawbplq.m   -  Draw bandpass low-Q-factor op amp RC biquad
%   drawbpmq.m   -  Draw bandpass medium-Q-factor op amp RC biquad
%   drawbrhq.m   -  Draw bandreject high-Q-factor op amp RC biquad
%   drawbrlq.m   -  Draw bandreject low-Q-factor op amp RC biquad
%   drawbrmq.m   -  Draw bandreject medium-Q-factor op amp RC biquad
%   drawhnhq.m   -  Draw highpass notch high-Q-factor op amp RC biquad
%   drawhnmq.m   -  Draw highpass notch medium-Q-factor op amp RC biquad
%   drawhphq.m   -  Draw highpass high-Q-factor op amp RC biquad
%   drawhplq.m   -  Draw highpass low-Q-factor op amp RC biquad
%   drawhpmq.m   -  Draw highpass medium-Q-factor op amp RC biquad
%   drawkhn.m    -  Draw Kerwin-Huelsman-Newcomb op amp RC biquad
%   drawlnhq.m   -  Draw lowpass notch high-Q-factor op amp RC biquad
%   drawlnmq.m   -  Draw lowpass notch medium-Q-factor op amp RC biquad
%   drawlphq.m   -  Draw lowpass high-Q-factor op amp RC biquad
%   drawlplq.m   -  Draw lowpass low-Q-factor op amp RC biquad
%   drawlpmq.m   -  Draw lowpass medium-Q-factor op amp RC biquad
%   
% EXAMPLE ALBUM\OTA
%   drawotab.m   -  Draw four OTA general biquad
%   drawotac.m   -  Draw four OTA notch biquad
%   drawotad.m   -  Draw five OTA universal biquad
%   drawotae.m   -  Draw simple lowpass notch OTA-C biquad
%   drawotaf.m   -  Draw four element universal OTA-C biquad
%   
% EXAMPLE ALBUM\RLC
%   drawlc1.m    -  Draw doubly terminated LC-ladder with complex zeros
%   drawlc2.m    -  Draw singly terminated LC-ladder with complex zeros
%   drawlc3.m    -  Draw singly terminated LC-ladder with zeros at origin
%   drawlc4.m    -  Draw LC-ladder
%   
% EXAMPLE ALBUM\UTILITY
%   drawall.m    -  Draw all objects
%   drawsk2b.m   -  Draw two cascaded Sallen-Key biquads
%   drawskoa.m   -  Draw biquad Sallen-Key (for drawsk2b.m)
%   
%   -------------------------------------------
%   Copyright (c) 1999-2000 by Lutovac & Tosic
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
                         
% This file is part of DrawFilt toolbox for MATLAB.
% Refer to the file LICENSE.TXT for full details.
%                        
% DrawFilt version 2.1, Copyright (c) 1999-2000 M. Lutovac and D. Tosic
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; see LICENSE.TXT for details.
%                       
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%                       
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc.,  59 Temple Place,  Suite 330,  Boston,
% MA  02111-1307  USA,  http://www.fsf.org/
