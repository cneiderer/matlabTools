DrawFilt Toolbox -- DRAWING FILTER REALIZATIONS in MATLAB

DrawFilt version 2.1, Copyright (c) 1999-2000 M. Lutovac and D. Tosic
   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/
   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/
This is free software.
   
DrawFilt is a MATLAB toolbox for creating schematics of filters.
By mouse point-and-click you draw filters in MATLAB figure windows. 
The filter schematic is saved as an M-file, and can be called 
as a stand alone function. You can use this function in your 
MATLAB scripts to illustrate or document the filter realization 
that you work on. DrawFilt produces publication quality 
filter schematics; the diagrams can be imported 
into your word processor as EPS, WMF or BMP figures. 
DrawFilt is easy to use, intuitive, and it is based on standard 
built-in MATLAB commands. Albums of example filter schematics 
accompany DrawFilt -- run afalbum.m and dfalbum.m scripts.
Run demodraw.m script for a quick tour about DrawFilt features.
 
INSTALLATION: DrawFilt is distributed in compressed form as the file
drawfilt.zip. Decompress drawfilt.zip with path names. You obtain

AFD\DrawFilt
AFD\DrawFilt\album
...

DrawFilt directory has to be appended to the MATLAB path. 

RUNNING: Run MATLAB and execute the following main scripts:

(a) drawfilt.m  --  Draw Digital and Analog Filter schematics
(b) drawdfil.m  --  Draw Digital Filter schematics
(c) afalbum.m   --  Album of Analog Filters
(d) dfalbum.m   --  Album of Digital Filters
(e) demodraw.m  --  DrawFilt demo

DRAWING: After invoking drawfilt.m the DrawFilt main window appears,
and you can draw a digital or analog filter realization.
A filter realization is a network of interconnected components:
delays, multipliers, adders, etc. (for digital filters), and
resistors, capacitors, amplifiers, etc. (for analog filters).
Click the R button to draw the resistor, click the Mult button
to draw the multiplier (gain), and so on.

Enter the position of element nodes by mouse click, 
(nodes are automatically snapped to the grid).
The element is centered between the selected nodes.

For example, if you want to draw a resistor, press the
R button, point and click where the first node should
appear, and point and click where the second node should appear.
You can draw only horizontal or vertical elements.

LINE, _|, and |_ buttons draw line segments which connect nodes.
IN and OUT buttons draw small circles that
identify filter input and output, respectively.
NODE button puts a dot that designates a node.

TEXT button adds a text label to the schematic.

NEW button clears the schematic and you can start a new drawing.
OPEN/SAVE button opens/saves schematic from/to a file.

Realization parameters can be edited by the EDIT button.
DELETE button erases selected schematic objects,
UNDO undoes the last deletion.

MA button creates a Mathematica package for drawing
the current filter realization in a Mathematica notebook.
The name of the package is drawmath.m and it resides 
in the current MATLAB directory. Run Mathematica and
open drawmaaf notebook to draw the schematic.

A group of buttons operates on a file named auxfilt.m,
and you can use them for quick save or open. In addition
the EPS button converts auxfilt.m to eps format.
The view button previews auxfilt.m without the grid and buttons.
Issue the help command to see how to call auxfilt.m as a
MATLAB function, i.e. type "help auxfilt" in the command window.

The example buttons show various filter schematics and
the process of creating a more complex filter from simpler sections.

DrawFilt saves a filter schematic as a MATLAB function 
which can be called in your MATLAB scripts. Feel free to
COMBINE the schematic with your scripts and plots.
Start dfalbum and click the button "draw +" to get an idea 
how you can use a DrawFilt drawings in a MATLAB subplot.


SEE ALSO:  
Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
        Filter Design for Signal Processing
           Using MATLAB and Mathematica
        Prentice Hall - ISBN 0-201-36130-2 
          http://www.prenhall.com/lutovac
 
To get updates of DrawFilt join our AFD e-mail list; contact us at
 lutovac@galeb.etf.bg.ac.yu   or   tosic@telekom.etf.bg.ac.yu
We welcome your feedback -- your suggestions are appreciated.

COPYRIGHT NOTICE: 
 This file is part of DrawFilt toolbox for MATLAB.
 Refer to the file LICENSE.TXT for full details.

 DrawFilt version 2.1, Copyright (C) 1999-2000 M. Lutovac and D. Tosic
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; see LICENSE.TXT for details.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
----------------- end-of-readmedf.txt ------------------------
